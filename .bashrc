This is an excerpt:

source ~/.colors

color_failure()
{
  if [ "$?" == "0" ]; then
    echo -e "$INPUT_COLOR"
  else
    echo -e "$FAIL_COLOR"
  fi
}

if [ "$color_prompt" = yes ]; then
    PS1="\[$TIME_COLOR\]\t\[$DASH_COLOR\]-\[$USERNAME_COLOR\]\u\[$PATH_COLOR\]\[$PATH_COLOR\]\w\[\033[m\]\[$GIT_COLOR\]\$(__git_ps1)\["'`color_failure`'"\]\$ \[$INPUT_COLOR\]"
else
    PS1="\t-\u\w\$(__git_ps1)\$ "
fi
