# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [ -n "$SSH_CLIENT" -a -z "`type -P cat`" ]
then
    # We are being invoked from a non-interactive SSH session
    # (as in "ssh host command") but 'cat' cannot be found
    # in $PATH.  Source /etc/profile so we get $PATH and other
    # essential variables.
    source /etc/profile
fi

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1='\u@\h \w [env]\$ '
else
    PS1='\u@\h \w\$ '
fi
alias ls='ls -p --color'
alias ll='ls -l'

export PATH=/root/.guix-profile/bin:$PATH

function update {
	guix pull && guix package -u
}

function reconf {
	sudo guix system reconfigure /etc/config.scm --max-jobs=5 --cores=4
}