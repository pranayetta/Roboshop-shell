echo -e "\e[31mInstalling the Nginx Server\e[0m"
dnf install nginx -y

echo -e "\e[32mRemoving  the previous Content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[33mDownloading the Frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
#We need to create a file here

echo -e "\e[34mRestarting the Nginx Server\e[0m"
systemctl enable nginx
systemctl restart nginx