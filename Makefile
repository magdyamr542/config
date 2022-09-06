SHELL=/bin/bash
HOMEDIR=$(HOME)
THINGS_TO_LINK=.zshrc .tmux.conf 

UNAME := $(shell uname)

all: install

link:
	echo "creating symlinks for [.tmux.conf, .zshrc, .aliases.sh]"
	ln -s ./tmux/.tmux.conf "$(HOMEDIR)/.tmux.conf"
	ln -s ./linux/.zshrc "$(HOMEDIR)/.zshrc"
	ln -s ./linux/.aliases.sh "$(HOMEDIR)/.aliases.sh"


install: link install-packages


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
		neovim
else
	@echo "Linux detected. Assuming there's an apt binary."	
	sudo apt install -y \
		git \
		tmux \
		zsh \
		curl \
		tree \
		powerline \
		neovim
	
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


.PHONY: nvim zsh install install-packages link all
