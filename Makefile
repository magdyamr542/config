SHELL=/bin/bash
HOMEDIR=${HOME}
PATH_VAR=${PATH}
CURRENT_USER=${USER}
THINGS_TO_LINK=.zshrc .tmux.conf 
VAGRANT_LSB_RELEASE := $(shell lsb_release -c)
UNAME := $(shell uname)

all: install

link:
	@echo "creating symlinks for [.tmux.conf, .zshrc, .aliases.sh , .funcs.sh]"
	ln -f -s ${PWD}/tmux/.tmux.conf $(HOMEDIR)/.tmux.conf
	ln -f -s ${PWD}/linux/.aliases.sh $(HOMEDIR)/.aliases.sh
	ln -f -s ${PWD}/linux/.funcs.sh $(HOMEDIR)/.funcs.sh
	mkdir -p $(HOMEDIR)/bin
	ln -f -s ${PWD}/scripts/touchr $(HOMEDIR)/bin/touchr

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
		curl \
		wget \
		coreutils \
		powerline \
		neovim \
		httpie 
else
	@echo "Linux detected. Assuming there's an apt binary."	
	sudo apt-get update -y
	sudo apt install -y \
		git \
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
		inxi \
		net-tools \
		jq \
		bat \
		imagemagick \
		ripgrep \
		apt-transport-https \
		python3-pip

 
	
endif


# zsh stuff
zsh:
	@echo "creating symlink to .zshrc"
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc
	@echo "installing zsh"
	sudo apt-get install -y zsh

oh-my-zsh:
	@echo "installing oh-my-zsh"
	wget -O install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	sh install.sh
	@echo "rm installed script"
	rm install.sh
	@echo "rm .zshrc.pre-oh-my-zsh created by oh-my-zsh"
	rm $(HOMEDIR)/.zshrc.pre-oh-my-zsh
	@echo "creating links again"
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc
	@echo "creating powerlevel10k"
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc
	@echo "starting zsh"
	chsh -s /usr/bin/zsh


oh-my-zsh-plugins:
	git clone https://github.com/zsh-users/zsh-autosuggestions $(HOMEDIR)/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOMEDIR)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting


powerlevel10k:
	@echo "creating symlink to .p10k.zsh"
	ln -f -s ${PWD}/linux/.p10k.zsh $(HOMEDIR)/.p10k.zsh
	@echo "installing powerlevel10k"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $(HOMEDIR)/.oh-my-zsh/custom/themes/powerlevel10k
	@echo "resource ~/.zshrc in order for the changes to take effect"

zsh-final:
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc

# end zsh stuff

nvim:
	@echo "setting up neovim repo from https://github.com/magdyamr542/nvim"
	mkdir -p $(HOMEDIR)/.config/
	mkdir -p $(HOMEDIR)/bin
	git clone https://github.com/magdyamr542/nvim $(HOMEDIR)/.config/nvim
	curl -LO https://github.com/neovim/neovim/releases/download/v0.7.0/nvim.appimage
	chmod u+x nvim.appimage
	mv ./nvim.appimage  $(HOMEDIR)/bin/nvim
	@echo "installing neovim plugins"
	nvim --headless +PlugInstall +qall
	@echo "installed neovim. make sure to have your $(HOMEDIR)/bin directory in your PATH"

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
	# install go1.4 that uses a c compiler to be able to install go versions that use a go compiler
	gvm install go1.4 -B
	gvm use go1.4
	export GOROOT_BOOTSTRAP=$GOROOT
	gvm install go1.19
	gvm use go1.19
	ln -s $(HOMEDIR)/.gvm/gos/go1.19/ ~/go

# tmux stuff
setup-tmux:
	@echo Add the command gnome-terminal -e 'tmux new' as a keyboard shortcut
	
install-tmux:
	@echo "installing tmux"
	./tmux/install.sh
	$(MAKE) install-tmux-plugin-manager

install-tmux-plugin-manager:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	tmux source ~/.tmux.conf
	@echo "Use <ctrl-b>I to install the tmux plugins"
# end tmux stuff

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

ansible:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install -y ansible

virtualbox:
	wget https://download.virtualbox.org/virtualbox/6.1.42/virtualbox-6.1_6.1.42-155177~Ubuntu~jammy_amd64.deb
	sudo apt --fix-broken install ./virtualbox-6.1_6.1.42-155177~Ubuntu~jammy_amd64.deb
	rm virtualbox-6.1_6.1.42-155177~Ubuntu~jammy_amd64.deb

vagrant:
	wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(VAGRANT_LSB_RELEASE) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	sudo apt update && sudo apt install vagrant


screen-recorder:
	sudo add-apt-repository ppa:atareao/atareao
	sudo apt install screenkeyfk

docker:
		@echo "Installing docker"
		curl -fsSL https://get.docker.com -o get-docker.sh
		sh get-docker.sh
		rm get-docker.sh
		@echo "Installed docker"

docker-remove:
		apt-get remove docker-ce docker-ce-cli
		dpkg -P docker-ce
		apt-get install -f
		apt autoremove --purge
		apt-get install --fix-broken -y
		@echo "Removed docker"
		@echo "Make sure to remove any groups that were created when installing"

.PHONY: nvim zsh install install-packages link all autojump
