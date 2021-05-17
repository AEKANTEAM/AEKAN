#!/usr/bin/env bash
cd $HOME/AEKAN
rm -rf $HOME/.telegram-cli
install(){
apt install dnsutils
rm -rf $HOME/.telegram-cli
sudo chmod +x tg
chmod +x Run
chmod +x AK
./AK
}
if [ "$1" = "ins" ]; then
install
fi
chmod +x install.sh
lua start.lua
