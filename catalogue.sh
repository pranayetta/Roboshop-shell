source common.sh
component=catalogue

nodejs

echo -e "${color}Copying mongodb repofile${nocolor}"
cp /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log_file

echo -e "${color}Install mongodb${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file

echo -e "${color}Load schema${nocolor}"
mongo --host mongodb-dev.pranaydevops73.me <$app_path/schema/$component.js &>>$log_file