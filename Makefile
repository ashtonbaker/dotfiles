SHELL := /bin/bash


pyenv:
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash.d/pyenv.sh
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash.d/pyenv.sh
	echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash.d/pyenv.sh


nvm:
	sudo apt --auto-remove purge npm
	sudo apt --auto-remove purge nodejs
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
	source ~/.bashrc
	nvm install stable

yvm: nvm
	nvm use stable
	curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node

