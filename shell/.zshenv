export REPOS="$HOME/repos"

export JAVA_HOME=$([[ "$(uname)" == "Darwin" ]] \
&& echo "$(dirname $(readlink $(which javac)))/java_home" \
|| echo "$(dirname $(dirname $(realpath $(which javac))))" \
)
export PATH="$JAVA_HOME:$PATH"

GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

YARNPATH="$HOME/.yarn"
export PATH="$YARNPATH/bin:$PATH"
