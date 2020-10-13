export ZSH=~/.ohmyzsh
export GOPATH=$HOME/go
ZSH_THEME="gnzh"
plugin=(git ruby rails)
source $ZSH/oh-my-zsh.sh

# Setup ssh-agent
if [ -f ~/.ssh-agent ]; then
    . ~/.ssh-agent
    echo "set up ssh-agent"
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID; then
    ssh-agent > ~/.ssh-agent
    . ~/.ssh-agent
    echo "re-set up ssh-agent"
fi

export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/bin:/usr/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:./node_modules/.bin
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias new-password='openssl rand -base64 100 | head -c 64 | egrep -v %'
alias g='git'
alias date-file='date "+%Y%m%d_%H%M%S"'

# export PYENV_ROOT="$HOME/.pyenv"
# eval "$(pyenv init -)"
# source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
# source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
# source <(kubectl completion zsh)

# load privates files
. ~/dotfiles/privatefiles/$(hostname)/*
while read -d $'\0' file; do
    source ${file}
done < <(find ~/dotfiles/privatefiles/$(hostname) -mindepth 1 -maxdepth 1 -print0)
