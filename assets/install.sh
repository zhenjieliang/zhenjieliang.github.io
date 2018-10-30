#! /bin/bash

echo "安装字体"
echo "-------------------------------------------"
cp -r fonts/ /usr/share/fonts/
apt update
wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
sudo dpkg -i ttf-mscorefonts-installer_3.6_all.deb
#apt install -y ttf-mscorefonts-installer
#cp -r fonts/ ~/.local/share/fonts/
chmod 777 /usr/share/fonts/
#chmod 777 ~/.local/share/fonts/

mkfontscale  #生成核心字体信息
mkfontdir
fc-cache -fv

echo "-------------------------------------------"
echo "安装所需软件"
echo "-------------------------------------------"

apt install -y git python vim texlive-full r-base python3 gcc g++ build-essential libpng12-dev python3-pip gdebi-core libfreetype6-dev
wget https://download2.rstudio.org/rstudio-server-1.1.456-amd64.deb
sudo gdebi rstudio-server-1.1.456-amd64.deb
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
pip install numpy
pip install pandas
pip install matplotlib
pip install seaborn
pip install scikit-learn

echo "-----------------------------------------"
echo "安装软件结束！"

