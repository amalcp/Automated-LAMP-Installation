###############################################################
#  Shell Script For Automating the LAMP stack on Ubuntu 14.04 #
#               Apache Ver - 2.4                              #
#               PHP Ver    - 5.5                              #
#               MySql Ver  - 5.5                              #
#                               Created By                    #
#                                       Amal CP               #
###############################################################
#!/bin/bash

echo "  Initiating Installation ........!!!! "
echo "+++============================+++"

sudo apt-get update

# LAMP Installation
sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client makepasswd
php5enmod mcrypt

#Setting up temporary MySql root password
pass=$(makepasswd --chars 16)
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password tempp@55'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password tempp@55'
sudo apt-get -y install mysql-server

sudo printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php;
#Restart all the installed services to verify that everything is installed properly

echo -e "\n"

service apache2 restart && service mysql restart > /dev/null

echo -e "\n"

if [ $? -ne 0 ]; then
   echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
   echo "All Done...!!!\nPlease check the Public_IP/info.php for the PHP info Page\n"
        mysqladmin -u root -p'tempp@55' password $pass
   echo "And Please use the following details to login MySql \nUser : root \nPass : $pass"
fi

echo -e "\n"
