export PATH="/usr/local/sbin:/usr/local/bin/:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

###
## General bash command
###
alias subl='/Applications/Sublime\ Text\.app/Contents/SharedSupport/bin/subl'
alias phpstorm='/usr/local/bin/pstorm'
alias updatedb="sudo /usr/libexec/locate.updatedb"

###
## Idiot bash alias
###
alias gitst="git st"
alias gits="git st"
alias gi="git"
alias gti="git"
alias githistory="git for-each-ref --sort=-committerdate refs/heads/"
alias ll="ls -l"
alias s="git st"
alias gitlog="git log --oneline --since={20.weeks.ago} --format=\"%h %cd %an %s\" --author=\"barbaro.daniele@gmail.com\""
alias gitlog100="git log --oneline --reverse --all --branches --since={100.weeks.ago} --format=\"%h %cd %an %s\" --author=\"barbaro.daniele@gmail.com\""
alias gitlogall="git log --oneline --since={30.weeks.ago} --format=\"%h %cd %an %s\""
alias gitbrhistory="git branch --sort=-committerdate"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'

alias artisan="php artisan"

###
## Show git branch (if any) directly in command prompt! :)
###

## define usefule things
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
# For Bold => 1;XXm instead of 0;XXm
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
GRAY="\[\033[1;30m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"

###
## Homebrew Command
###
alias nginx.start='sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.stop='sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.restart='nginx.stop && nginx.start'

alias php-fpm.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist"
alias php-fpm.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist"
alias php-fpm.restart='php-fpm.stop && php-fpm.start'

alias nginx.logs='cd /usr/local/etc/nginx/logs/'
alias nginx.sites="cd /usr/local/etc/nginx/sites-available/"

alias ls='ls -GFh'

export HISTTIMEFORMAT="%d/%m/%y %T "
LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
export CLICOLOR=1
export LSCOLORS