export ZSH=~/.oh-my-zsh
export GOPATH=$HOME/go
ZSH_THEME="gnzh"
plugin=(git ruby rails)
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/bin:/usr/bin:$PATH
source $ZSH/oh-my-zsh.sh

# Setup ssh-agent
if [ -f ~/.ssh-agent ]; then
    . ~/.ssh-agent
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID; then
    ssh-agent > ~/.ssh-agent
    . ~/.ssh-agent
fi
. ./privatefiles/*

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
alias newPassword='openssl rand -base64 100 | head -c 64 | egrep -v %'
alias g='git'
alias date-file='date "+%Y%m%d_%H%M%S"'

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
source <(kubectl completion zsh)
