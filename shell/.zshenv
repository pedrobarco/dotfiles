export REPOS="$HOME/repos"

KREW_ROOT="$HOME/.krew"
export PATH="$KREW_ROOT/bin:$PATH"

GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

YARNPATH="$HOME/.yarn"
export PATH="$YARNPATH/bin:$PATH"

CARGOPATH="$HOME/.cargo"
export PATH="$CARGOPATH/bin:$PATH"

if [[ "$(uname)" == "Darwin" ]]; then
    BREW_PATH="/opt/homebrew"
    export PATH="$BREW_PATH/bin:$PATH"

    export JAVA_HOME="$BREW_PATH/opt/openjdk@11"
    export PATH="$JAVA_HOME/bin:$PATH"
fi
