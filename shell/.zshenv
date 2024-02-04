export REPOS="$HOME/repos"

LOCAL_ROOT="$HOME/.local"
export PATH="$LOCAL_ROOT/bin:$PATH"

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

# added by Nix installer
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi

if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh;
fi
