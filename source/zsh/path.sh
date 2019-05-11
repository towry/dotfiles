_PATH_STR="$PATH:/usr/local/opt/openssl/bin\
:/Library/Frameworks/Python.framework/Versions/3.4/bin\
:/usr/local/bin\
:/usr/local/go/bin\
:/usr/local/git/bin\
:/usr/local/sbin\
:$GOPATH/bin\
:$HOME/.cargo/bin"

# nvm
if [ -f "~/.nvm/alias/default" ]; then
    DEF_NODE_VER="$(< ~/.nvm/alias/default)"
    DEF_NODE_BIN_PATH=":$HOME/.nvm/versions/node/$DEF_NODE_VER/bin"
    _PATH_STR+=DEF_NODE_BIN_PATH
fi

# --------- END --------
export GOPATH=$HOME/workspace/goenv
export PATH=$_PATH_STR