SHELL=/bin/bash
HOMEDIR=${HOME}
PATH_VAR=${PATH}
THINGS_TO_LINK=.zshrc .tmux.conf 

UNAME := $(shell uname)

all: install

link:
	echo "creating symlinks for [.tmux.conf, .zshrc, .aliases.sh]"
	ln -f -s ${PWD}/tmux/.tmux.conf $(HOMEDIR)/.tmux.conf
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc
	ln -f -s ${PWD}/linux/.aliases.sh $(HOMEDIR)/.aliases.sh

install: install-packages

init-bin:
	mkdir -p $(HOMEDIR)/bin
	export PATH=$(PATH_VAR):$(HOMEDIR)/bin

install-packages:
ifeq ($(UNAME),Darwin)
	@echo "Darwin detected"
	brew install \
		vim \
		git \
		tmux \
		zsh \
		curl \
		wget \
		coreutils \
		powerline \
		neovim \
		httpie 
else
	@echo "Linux detected. Assuming there's an apt binary."	
	sudo apt install -y \
		git \
		tmux \
		zsh \
		curl \
		tree \
		powerline \
		neovim \
	  mercurial \
		binutils \
		bison \
		gcc  \
		build-essential \
		httpie
	
endif

zsh:
	echo "installing oh-my-zsh"
	curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o install-oh-my-zsh.sh;
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install-oh-my-zsh.sh;
	sh install-oh-my-zsh.sh
	rm install-oh-my-zsh.sh
	chsh -s /usr/bin/zsh

nvim:
	echo "setting up neovim repo from https://github.com/magdyamr542/nvim"
	mkdir -p $(HOMEDIR)/.config/
	git clone https://github.com/magdyamr542/nvim $(HOMEDIR)/.config/nvim
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	mv ./nvim.appimage  $(HOMEDIR)/bin/nvim
	nvim --headless +PlugInstall +qall

nodejs:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	nvm install --lts

autojump:
	git clone git@github.com:wting/autojump.git
	cd autojump && ./install.py && cd .. && rm -rf autojump

pyenv:
	curl https://pyenv.run | bash

golang:
	bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
	source ~/.gvm/scripts/gvm
	gvm install go1.19.1

setup-tmux:
	@echo Add the command gnome-terminal -e 'tmux new' as a keyboard shortcut

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

sdk-man:
	 curl -s "https://get.sdkman.io" | bash
	 source "$(HOME)/.sdkman/bin/sdkman-init.sh"

chrome:
	 wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	 sudo apt install ./google-chrome-stable_current_amd64.deb
	 rm ./google-chrome-stable_current_amd64.deb

manual-install:
	@echo "Don't forget to manually install these"
	@echo "Project root -> https://github.com/magdyamr542/project-root"
	@echo "Docker -> https://github.com/docker/docker-install"
	@echo "Java after installing sdkman"
	@echo "Sync vscode settings"


	
.PHONY: nvim zsh install install-packages link all autojump
