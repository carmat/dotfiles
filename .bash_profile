# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Use PHP 5.6.21
export PATH="/usr/local/php5/bin:$PATH"

# Maven for Java/Tomcat
# Java/Maven
export MAVEN_HOME="/opt/apache-maven-3.5.2"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home"
export M2_HOME="$HOME/.m2"
# export MAVEN_OPTS="-Xms1024m -Xmx1G -javaagent:$HOME/springloaded-1.2.5.RELEASE.jar -noverify"
export PATH="$MAVEN_HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

## Show full path and current branch in bash
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

## Git auto-complete branch names and commands
## @usage: TAB to complete/show options
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
	complete -o default -o nospace -F _git gti;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

### --- UNUSED --- ###

# Use Ruby 2.2.1
# export PATH="/opt/ruby2.2.1/bin/ruby:$PATH"

# Use Composer for Laravel
# export PATH="~/.composer/vendor/bin:$PATH"

# export PATH="$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"

## Homebrew auto-complete commands
## @usage: TAB to complete/show options
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
# fi

# [[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
# ln -s /usr/local/Cellar/openssl/1.0.2h_1/bin/openssl /usr/local/bin/openssl
