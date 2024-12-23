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
    export HOMEBREW_PREFIX="/opt/homebrew";
    export PATH="$HOMEBREW_PREFIX/bin:$PATH"

    export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk@11"
    export PATH="$JAVA_HOME/bin:$PATH"
fi

if [[ "$(uname)" == "Linux" ]]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
    export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
    export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}";
    export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";

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
