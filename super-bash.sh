echo "
#Recursive copy
alias cp='cp -rv'
#List all files
alias ls='ls --color=auto -ACF'
alias ll='ls --color=auto -alF'
#Show Verbose
alias mv='mv -v'
#Create parent directories
alias mkdir='mkdir -pv'
#Continue partially downloaded file
alias wget='wget -c'

#Common Python Commands
alias pym='python3 manage.py'
alias mkenv='python3 -m venv env'
alias startenv='source env/bin/activate && which python3'
alias stopenv='deactivate'

#Linux Hacks
#start apache service
alias apachi='systemctl start apache2'
#random 32bit password generation
alias pass='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;'
#Logs of past 24 hrs
alias logs='find . -type f -mtime +1 -name "*.log" -exec zip -m {}.zip {} \; >/dev/null'
#IPs connected to port80
alias ip80='netstat -tn 2>/dev/null | grep :80 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head'
#cpu intel architecture family
alias cpu='cat /sys/devices/cpu/caps/pmu_name'
#Get all Google ipv4/6 subnets for a iptables firewall
alias subnets='for NETBLOCK in $(echo _netblocks.google.com _netblocks2.google.com _netblocks3.google.com); do nslookup -q=TXT $NETBLOCK ; done | tr " " "\n" | grep ^ip[46]: | cut -d: -f2- | sort'
#Git commit logs
alias gitlog='git log --since='last month' --author="$(git config user.name)" --oneline'
#Scan all open ports without any required program
alias scan='for i in {1..65535}; do (echo < /dev/tcp/127.0.0.1/$i) &>/dev/null && printf "\n[+] Open Port at\n: \t%d\n" "$i" || printf "."; done'
#Scan entire Git repos for dangerous Service IDs
alias gitsecret='git ls-tree --full-tree -r --name-only HEAD | xargs egrep -w '[A-Z0-9]{20}''
#Top 10 Memory Processes 
ps aux | sort -rk 4,4 | head -n 10 | awk '{print $4,$11}'
#To view access point speed, signal strength and security informations
alias wifi='nmcli dev wifi'
#Network Info
alias network='sudo lshw -C network'
" >> ~/.bash_aliases

echo "
#Show contents of the directory after changing into it
function cd () {
  builtin cd "$1" 
  ls -ACF
}

# Hugo install or upgrade eg. gethugo 0.57.2
function gethugo () {
  wget -q -P tmp/ https://github.com/gohugoio/hugo/releases/download/v"$@"/hugo_extended_"$@"_Linux-64bit.tar.gz
  tar xf tmp/hugo_extended_"$@"_Linux-64bit.tar.gz -C tmp/
  sudo mv -f tmp/hugo /usr/local/bin/
  rm -rf tmp/
  hugo version
}

#Get golang
function getgolang () {
  sudo rm -rf /usr/local/go
  wget -q -P tmp/ https://dl.google.com/go/go"$@".linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf tmp/go"$@".linux-amd64.tar.gz
  rm -rf tmp/
  go version
}

#Gitlab remote origin with glab *username*
function glab () {
  git remote set-url origin --add git@gitlab.com:"$@"/"${PWD##*/}".git
  git remote -v
}

# Let's name Color Codes
txtcyn='\[\e[0;96m\]' # Cyan
txtpur='\[\e[0;35m\]' # Purple
txtwht='\[\e[0;37m\]' # White
txtrst='\[\e[0m\]' # Text Reset# Which (C)olour for what part of the prompt?
pathC="${txtcyn}"
gitC="${txtpur}"
pointerC="${txtwht}"
normalC="${txtrst}"# Get the name of our branch and put parenthesis around it
gitBranch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}# Build the prompt
export PS1="${pathC}\w ${gitC}\$(gitBranch) ${pointerC}\$${normalC} "

export PS1="${userC}\u ${normalC}at \t >"

" >> ~/.bashrc
