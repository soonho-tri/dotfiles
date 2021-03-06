restart_emacs() {
    # Restart emacs daemon
    if [ "$(uname -s)" = 'Darwin' ]; then
	brew services restart d12frosted/emacs-plus/emacs-plus@27
    else
        systemctl --user restart emacs.service
    fi
}

update() {
    update_common() {
	# Pull dotfiles
	git -C ~/dotfiles pull

	zinit self-update
	zinit update

	# Update / upgrade emacs packages
	emacs --no-window-system --eval "(package-utils-upgrade-all)" --kill

	if [ -e "${HOME}/.pyenv" ]; then
	    pyenv rehash
	fi
    }

    update_darwin() {
	# Update / upgrade packages installed via homebrew
	brew update && brew upgrade && brew upgrade --cask && brew cleanup -s

	# Upgrade packages installed via Mac App Store
	mas upgrade

	# MacOS Software Update
	softwareupdate -i -a
    }

    update_ubuntu() {
	# Update / upgrade packages installed via apt
	sudo apt-get update
	sudo apt-get upgrade --yes
	sudo apt-get autoremove
	sudo apt-get autoclean
    }

    update_common
    if [ "$(uname -s)" = 'Darwin' ]; then
	update_darwin
    else
	update_ubuntu
    fi
    restart_emacs

    # poetry, https://python-poetry.org
    poetry self update
}
