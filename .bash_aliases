# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# deletes local reference to remote branches that no longer exist
alias prune="git remote prune origin |  grep -o -E 'origin/[^ ]+' | sed 's/origin\///' | xargs git branch -d"

# Git nonsense
alias fs="git status --porcelain"
alias fdr="git reset --hard && git clean -fd"
alias fddr="git reset --hard && git clean -xfdf"
alias fdb="git branch -D"
alias fa="git add"
alias fz="git push"
alias fq="git pull"
alias fc="git commit -m"
alias fb="git checkout"
alias fbb="git checkout -b"
alias ff="git diff"

alias subup-force="git submodule update --init --recursive --force && git submodule foreach --recursive git clean -ffd"

merge-when-github-is-happy() {
  gh pr checks $1 --watch && notify-send "Ready to merge " $1 && gh pr merge -d $1
}

