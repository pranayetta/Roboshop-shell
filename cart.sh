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
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[32mInstalling the dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
npm install &>>/tmp/roboshop.log

echo -e "\e[32mCopying the cart service file\e[0m"
cp /home/centos/Roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[32mReloading\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32mEnable and start\e[0m"
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log
