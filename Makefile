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
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	mv ./nvim.appimage  $(HOMEDIR)/bin/nvim
	nvim --headless +PlugInstall +qall




.PHONY: nvim zsh install install-packages link all

