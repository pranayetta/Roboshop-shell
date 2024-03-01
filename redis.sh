echo -e "\e[32mInstalling the redis repo\e[0m"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo -e "\e[32mEnabling the redis 6.2\e[0m"
dnf module enable redis:remi-6.2- -y &>>/tmp/roboshop.log

echo -e "\e[32mInstalling the redis\e[0m"
dnf install redis -y &>>/tmp/roboshop.log

echo -e "\e[32mChanging the IP\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log

echo -e "\e[32mRestarting the redis\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log