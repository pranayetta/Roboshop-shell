echo -e "\e[32mDisabling the default Nodejs and enabling 18th version\e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "\e[32mInstalling the nodejs\e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[32mAdding the application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32mCreating the application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[32mDownloading the application code and extracting\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[32mInstalling the dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
npm install &>>/tmp/roboshop.log

echo -e "\e[32mCopying the catalogue service file\e[0m"
cp /home/centos/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[32mreloading\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32menable and start\e[0m"
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

echo -e "\e[32mCopying mongodb repofile\e[0m"
cp /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[32mInstall mongodb\e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[32mLoad schema\e[0m"
mongo --host mongodb-dev.pranaydevops73.me </app/schema/catalogue.js &>>/tmp/roboshop.log