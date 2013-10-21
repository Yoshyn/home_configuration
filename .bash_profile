# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

HISTSIZE=1000
HISTFILESIZE=2000

# Do some clean on ubuntu
cleanUbuntu() {
  echo "--- Removing unused package and clean cache ---"
  sudo apt-get remove --purge `deborphan`
  sudo apt-get autoremove --purge
  sudo apt-get clean
  echo "--- Removing unused kernel ---"
  sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
  echo "--- Remove all old conf file ---"
  [ ! -z $(dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2 | tr -d '\n') ] && sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2)
  echo "--- Remove trash ---"
  sudo rm -r -f ~/.local/share/Trash/files/*
}

# Identify and search for active network connections
spy() {
  lsof -i -P +c 0 +M | grep -i "$1"
}

# What's gobbling the memory?
whoGobbleMemory() {
  ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15
}

# Alias on upgrade
alias upgradeUbuntu='sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean'

# See : https://github.com/mernen/completion-ruby
. ~/completion-ruby/completion-ruby-all

shopt -s cdspell
export MANPAGER="/usr/bin/most -s"

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups
# append history entries..
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
