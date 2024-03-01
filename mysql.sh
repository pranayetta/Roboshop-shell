echo -e "\e[32mDisabling mysql default version\e[0m"
dnf module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[32mCopying the repo file\e[0m"
cp /home/centos/Roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[32mInstalling mysql 5.7 version\e[0m"
dnf install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[32mRestarting mysql\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[32mSetting the password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log