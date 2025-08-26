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

PYTHON_ROOT="$(python3 -m site --user-base)"
export PATH="$PYTHON_ROOT/bin:$PATH"

if [[ "$(uname)" == "Darwin" ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew";

    export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk@21"
    export PATH="$JAVA_HOME/bin:$PATH"
fi

if [[ "$(uname)" == "Linux" ]]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";

    GOOGLE_CLOUD_SDK_PATH="/opt/google-cloud-sdk"
    export PATH="$GOOGLE_CLOUD_SDK_PATH/bin:$PATH"
fi

# added by Nix installer
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi

if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh;
fi
