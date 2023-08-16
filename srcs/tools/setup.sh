set -e

apt update && apt upgrade
timedatectl set-timezone 'Europe/Berlin'

read -p 'multipress_setup.sh: Enter your sudo user: ' SUDO_USER
useradd $SUDO_USER
passwd $SUDO_USER
adduser $SUDO_USER sudo
sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
sudo systemctl restart sshd

ufw default deny incoming
ufw allow ssh
ufw allow http
ufw allow https
ufw enable

git clone https://github.com/PythonGermany/no-inception.git
cd no-inception
apt-get install make
echo "ubuntu" | make docker_install
make setup