set -e # exit on error

sudo apt install fd-find ripgrep bat git vim make gcc g++ tldr vifm -y

sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
sudo ln -s /usr/bin/batcat /usr/local/bin/bat

nvm install 18 --lts
nvm alias default 18
nvm use 18
