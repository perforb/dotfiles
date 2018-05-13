if [ -z "$SSH_AGENT_PID" ] ; then
  eval `ssh-agent`
  ssh-add
fi

export PATH=/usr/local/mecab/bin:$PATH
