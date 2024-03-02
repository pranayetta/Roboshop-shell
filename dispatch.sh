echo -e "\e[32mInstalling python\e[0m"
dnf install golang -y &>>/tmp/roboshop.log

echo -e "\e[32mAdding the application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32mCreating the application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[32mDownloading the application code and extracting\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[32mInstalling the dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[32mCopying the dispatch service file\e[0m"
cp /home/centos/Roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[32mReloading\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32mEnable and restart\e[0m"
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log

