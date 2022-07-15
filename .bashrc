This is an excerpt:

source ~/.colors.sh

if [ "$color_prompt" = yes ]; then
    PS1="\[$TIME_COLOR\]\t\[$DASH_COLOR\]-\[$USERNAME_COLOR\]\u\[$PATH_COLOR\]\[$PATH_COLOR\]\w\[\033[m\]\[$GIT_COLOR\]\$(__git_ps1)\[$INPUT_COLOR\]\$ "

else
    PS1="\t-\u\w\$(__git_ps1)\$ "
fi
