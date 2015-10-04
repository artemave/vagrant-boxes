#!/bin/sh

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-vivid main" >> /etc/apt/sources.list.d/docker.list
curl -L https://github.com/docker/compose/releases/download/1.4.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

sudo apt-get update
sudo apt-get install -y \
  docker-engine \
  tree \
  tmux \
  git \
  direnv \
  silversearcher-ag \
  exuberant-ctags \
  htop \
  zsh \
  tig \
  nodejs \ # this and below are only needed for everybody.voting development
  npm \
  postgresql-client

# vim +lua +ruby +python +perl
sudo apt-get remove -y --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common
sudo apt-get install -y liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev \
  libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev xauth xclip
sudo mkdir /usr/include/lua5.1/include
sudo mv /usr/include/lua5.1/*.h /usr/include/lua5.1/include/
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --with-x \
            --enable-rubyinterp \
            --enable-largefile \
            --disable-netbeans \
            --enable-pythoninterp \
            --enable-perlinterp \
            --enable-luainterp \
            --with-luajit \
            --enable-fail-if-missing \
            --with-lua-prefix=/usr/include/lua5.1 \
            --enable-cscope \
            --with-python-config-dir=/usr/lib/python2.7/config
make
sudo make install
