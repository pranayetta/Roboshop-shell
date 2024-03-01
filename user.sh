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
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/user.zip &>>/tmp/roboshop.log

echo -e "\e[32mInstalling the dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
npm install &>>/tmp/roboshop.log

echo -e "\e[32mCopying the user service file\e[0m"
cp /home/centos/Roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[32mreloading\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32menable and start\e[0m"
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log
