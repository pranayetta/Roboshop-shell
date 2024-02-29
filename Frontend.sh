echo -e "\e[31mInstalling the Nginx Server\e[0m"
dnf install nginx -y  >1/tmp/roboshop.log

echo -e "\e[32mRemoving  the previous Content\e[0m"
rm -rf /usr/share/nginx/html/* >1/tmp/roboshop.log

echo -e "\e[33mDownloading the Frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html >1/tmp/roboshop.log
unzip /tmp/frontend.zip >1/tmp/roboshop.log
#We need to create a file here

echo -e "\e[34mRestarting the Nginx Server\e[0m"
systemctl enable nginx >1/tmp/roboshop.log
systemctl restart nginx >1/tmp/roboshop.log