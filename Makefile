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
		httpie \
		software-properties-common \
		fd-find \
		lua5.3 \
		ripgrep \
		inxi \
		net-tools \
		apt-transport-https

 
	
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
	curl -LO https://github.com/neovim/neovim/releases/download/v0.7.0/nvim.appimage
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
	
install-tmux:
	./tmux/install.sh

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

vscode:
	 wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	 sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	 sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	 sudo apt update
	 sudo apt install code
	 rm packages.microsoft.gpg

backup-installed-commands:
	dpkg --clear-selections
	sudo apt install < ./linux/installed-commands

aws-cli:
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	./aws/install -i /usr/local/aws-cli -b /usr/local/bin
	sudo rm -rf aws awscliv2.zip

ngrok:
	curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok


	
.PHONY: nvim zsh install install-packages link all autojump
