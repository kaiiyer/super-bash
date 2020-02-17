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


" >> ~/.bash_aliases
echo "
#Show contents of the directory after changing into it
function cd () {
  builtin cd "$1" 
  ls -ACF
}
" >> ~/.bashrc
