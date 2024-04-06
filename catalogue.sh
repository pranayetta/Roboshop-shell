source common.sh
component=catalogue

echo -e "${color}Disabling the default Nodejs and enabling 18th version${nocolor}"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

echo -e "${color}Installing the nodejs${nocolor}"
dnf install nodejs -y &>>$log_file

echo -e "${color}Adding the application user${nocolor}"
useradd roboshop &>>$log_file

echo -e "${color}Creating the application directory${nocolor}"
rm -rf $app_path &>>$log_file
mkdir $app_path &>>$log_file

echo -e "${color}Downloading the application code and extracting${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
cd $app_path &>>$log_file
unzip /tmp/$component.zip &>>$log_file

echo -e "${color}Installing the dependencies${nocolor}"
cd $app_path &>>$log_file
npm install &>>$log_file

echo -e "${color}Copying the $component service file${nocolor}"
cp /home/centos/Roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file

echo -e "${color}reloading${nocolor}"
systemctl daemon-reload &>>$log_file

echo -e "${color}enable and start${nocolor}"
systemctl enable $component &>>$log_file
systemctl restart $component &>>$log_file

echo -e "${color}Copying mongodb repofile${nocolor}"
cp /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log_file

echo -e "${color}Install mongodb${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file

echo -e "${color}Load schema${nocolor}"
mongo --host mongodb-dev.pranaydevops73.me <$app_path/schema/$component.js &>>$log_file