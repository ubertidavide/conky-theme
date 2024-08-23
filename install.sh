sudo apt-get update && sudo apt-get upgrade -y
sudo apt install -y conky-all sensors
cp conky.conf /etc/conky/conky.conf
cp conky.desktop ~/.config/autostart/conky.desktop
