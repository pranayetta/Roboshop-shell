echo -e "\e[32mInstalling the maven\e[0m"
dnf install maven &>>/tmp/roboshop.log

echo -e "\e[32mAdding the application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32mCreating the application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[32mDownloading the application code and extracting\e[0m"
curl -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[32mInstalling the dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[32mCopying the catalogue service file\e[0m"
cp /home/centos/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[32mreloading\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32menable and start\e[0m"
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log

echo -e "\e[32mInstall mysql\e[0m"
dnf install mysql -y &>>/tmp/roboshop.log

echo -e "\e[32mLoad schema\e[0m"
mysql -h mysql-dev.pranaydevops73.me -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[32mRestart\e[0m"
systemctl restart shipping &>>/tmp/roboshop.log