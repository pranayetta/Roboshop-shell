#copy the repo file

echo -e "\e[35mCopying the repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[36mInstalling the mongodb\e[0m"
dnf install mongodb-org -y

#modify the file
echo -e "\e[32mModifying the file\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[33mRestarting the mongodb\e[0m"
systemctl enable mongod
systemctl restart mongod