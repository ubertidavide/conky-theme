sudo apt-get update && sudo apt-get upgrade -y
sudo apt install -y conky-all
sudo cp conky.conf /etc/conky/conky.conf
sudo cp conky_functions.lua /etc/conky/conky_functions.lua
sudo cp conky.desktop ~/.config/autostart/conky.desktop
