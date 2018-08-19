if [ -z "$SSH_AGENT_PID" ] ; then
  eval `ssh-agent`
  ssh-add
fi

GOPATH="$HOME/go"

export GOPATH
export PATH=/usr/local/mecab/bin:$PATH
