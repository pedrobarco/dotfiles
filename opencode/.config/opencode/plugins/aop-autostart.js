// Auto-starts augment-open-proxy (AOP) on startup when it is not already
// listening, so the `augment` provider in opencode.json can reach it.
//
// AOP can crash mid-session (UnhandledPromiseRejection on a cancelled stream),
// so we don't run it directly. Instead we spawn a detached, self-contained Bun
// keep-alive supervisor (SUPERVISOR below, run via `bun -e`) that relaunches AOP
// whenever it exits. Keeping it inline means one plugin file, one runtime (Bun),
// and nothing extra in the plugins dir for opencode to load.
const AOP_URL = "http://localhost:7888/v1/models"

async function isRunning() {
  try {
    const res = await fetch(AOP_URL, { signal: AbortSignal.timeout(1000) })
    return res.ok
  } catch {
    return false
  }
}

// Runs under `bun -e`, detached from opencode. Restarts AOP on exit with a
// capped backoff; a pidfile guard ensures only one supervisor runs at a time.
const SUPERVISOR = `
const { spawn } = require("node:child_process")
const fs = require("node:fs")
const LOG = "/tmp/aop.log"
const PIDFILE = "/tmp/aop-supervisor.pid"
const MIN = 500, MAX = 10000
const log = (m) => { try { fs.appendFileSync(LOG, "[supervisor " + new Date().toISOString() + "] " + m + "\\n") } catch {} }
try {
  if (fs.existsSync(PIDFILE)) {
    const pid = parseInt(fs.readFileSync(PIDFILE, "utf8").trim(), 10)
    if (pid) { try { process.kill(pid, 0); log("supervisor already running; exiting"); process.exit(0) } catch {} }
  }
} catch {}
fs.writeFileSync(PIDFILE, String(process.pid))
const cleanup = () => { try { fs.unlinkSync(PIDFILE) } catch {} }
process.on("SIGTERM", () => { cleanup(); process.exit(0) })
process.on("SIGINT", () => { cleanup(); process.exit(0) })
process.on("exit", cleanup)
let backoff = MIN
function runOnce() {
  const out = fs.openSync(LOG, "a")
  const child = spawn("npx", ["-y", "augment-open-proxy"], { stdio: ["ignore", out, out] })
  child.on("spawn", () => log("started augment-open-proxy (pid " + child.pid + ")"))
  child.on("exit", (code, signal) => {
    log("augment-open-proxy exited (code=" + code + " signal=" + signal + "); restarting")
    setTimeout(runOnce, backoff); backoff = Math.min(backoff * 2, MAX)
  })
  child.on("error", (err) => {
    log("failed to spawn augment-open-proxy: " + err.message + "; retrying")
    setTimeout(runOnce, backoff); backoff = Math.min(backoff * 2, MAX)
  })
  setTimeout(() => { backoff = MIN }, 15000)
}
log("supervisor starting")
runOnce()
`

export const AugmentOpenProxy = async () => {
  if (await isRunning()) return {}

  try {
    // Bun's $ shell does not support redirection/backgrounding, so spawn the
    // supervisor detached and unref so it (and the proxy) outlive opencode.
    const log = Bun.file("/tmp/aop.log")
    const proc = Bun.spawn(["bun", "-e", SUPERVISOR], {
      stdout: log,
      stderr: log,
      stdin: "ignore",
    })
    proc.unref()
  } catch {
    // Non-fatal: opencode still works, provider just won't reach AOP.
  }

  return {}
}
