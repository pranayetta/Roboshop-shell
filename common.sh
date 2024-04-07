color="\e[32m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

app_presetup() {
    echo -e "${color}Adding the application user${nocolor}"
    useradd roboshop &>>$log_file

    echo -e "${color}Creating the application directory${nocolor}"
    rm -rf $app_path &>>$log_file
    mkdir $app_path &>>$log_file

    echo -e "${color}Downloading the application code and extracting${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &${log_file}
    cd /app &${log_file}
    unzip /tmp/${component}.zip &${log_file}
}

systemd_setup() {
    echo -e "${color}reloading${nocolor}"
    systemctl daemon-reload &${log_file}

    echo -e "${color}enable and start${nocolor}"
    systemctl enable ${component} &${log_file}
    systemctl restart ${component} &${log_file}
}
nodejs() {
    echo -e "${color}Disabling the default Nodejs and enabling 18th version${nocolor}"
    dnf module disable nodejs -y &>>$log_file
    dnf module enable nodejs:18 -y &>>$log_file

    echo -e "${color}Installing the nodejs${nocolor}"
    dnf install nodejs -y &>>$log_file

    app_presetup


    echo -e "${color}Installing the dependencies${nocolor}"
    cd $app_path &>>$log_file
    npm install &>>$log_file

    echo -e "${color}Copying the $component service file${nocolor}"
    cp /home/centos/Roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file

    systemd_setup
}

mongodb_schema_setup() {
      echo -e "${color}Copying the ${component} service file${nocolor}"
      cp /home/centos/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service &${log_file}

      systemd_setup
}

mysql_schema_setup() {
   echo -e "${color}Install mysql${nocolor}"
   dnf install mysql -y &${log_file}

   echo -e "${color}Load schema${nocolor}"
   mysql -h mysql-dev.pranaydevops73.me -uroot -pRoboShop@1 < /app/schema/${component}.sql &${log_file}
}

maven() {
  echo -e "${color}Installing the maven${nocolor}"
  dnf install maven &${log_file}

  app_presetup

  echo -e "${color}Installing the dependencies${nocolor}"
  cd /app &${log_file}
  mvn clean package &${log_file}
  mv target/${component}-1.0.jar ${component}.jar &${log_file}

  echo -e "${color}Copying the catalogue service file${nocolor}"
  cp /home/centos/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service &${log_file}

  mysql_schema_setup

  echo -e "${color}Restart${nocolor}"
  systemctl restart ${component} &${log_file}

  systemd_setup


}