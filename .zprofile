if [ -z "$SSH_AGENT_PID" ] ; then
  eval `ssh-agent`
  ssh-add
fi

export GOPATH="$HOME/go"
export PATH=/usr/local/mecab/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/Library/Python/3.6/bin:$PATH

