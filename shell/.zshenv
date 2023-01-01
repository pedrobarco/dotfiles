export TERM=xterm-256color
export COLORTERM=truecolor

export REPOS="$HOME/repos"

KREW_ROOT="$HOME/.krew"
export PATH="$KREW_ROOT/bin:$PATH"

export JAVA_HOME="$(dirname $(dirname $(realpath $(which javac))))"
export PATH="$JAVA_HOME:$PATH"

GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

YARNPATH="$HOME/.yarn"
export PATH="$YARNPATH/bin:$PATH"
