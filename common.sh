dir_path=$(pwd)
log_file=/tmp/roboshop.log
rm -f $log_file

Status_Print() {
  if [ $1 -eq 0 ];then
    echo SUCCESS
  else
    echo FAILURE
    exit1
  fi
}

SYSTEMD_SETUP() {
    echo Copying the Application service file
    cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service &>> log_file
    Status_Print $?
    echo Loading the service
    systemctl daemon-reload &>>log_file
    Status_Print $?
    echo Enabling the service
    systemctl enable $app_name &>>log_file
    Status_Print $?
    echo Starting the service
    systemstl start $app_name &>>log_file
    Status_Print $?
}

APP_PREREQ() {
    echo Adding Application User
    useradd roboshop &>>log_file
    Status_Print $?
    echo Removing the app directoy
    rm -rf /app &>>log_file
    Status_Print $?
    echo creating the app directoy
    mkdir /app &>>log_file
    Status_Print $?
    echo Removing the temp file
    rm -f /tmp/$app_name.zip &>>log_file
    Status_Print $?
    echo Copying the $app_name Content
    curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>log_file
    Status_Print $?
    echo Changing to App directory
    cd /app &>>log_file
    Status_Print $?
    echo Unzip the $app_name Content
    unzip /tmp/$app_name.zip &>>log_file
    Status_Print $?
}

NODEJS() {
  echo Disabling NodeJS
  dnf module disable nodejs -y &>>log_file
  Status_Print $?
  echo Enabling NodeJS
  dnf module enable nodejs:20 -y &>>log_file
  Status_Print $?
  echo Installing NodeJS
  dnf install nodejs -y &>>log_file
  Status_Print $?
  APP_PREREQ
  echo Downloading Dependencies
  npm install &>>log_file
  Status_Print $?
  SYSTEMD_SETUP
}

JAVA() {
  echo Installing Maven
  dnf install maven -y &>>log_file
  APP_PREREQ
  echo Installing Dependencies
  mvn clean package &>>log_file
  echo Moving the $app_name.jar file location
  mv target/$app_name-1.0.jar $app_name.jar &>>log_file

  SYSTEMD_SETUP
}

PYTHON() {
  echo Installing Python
  dnf install python3 gcc python3-devel -y &>>log_file
  APP_PREREQ
  echo Installing Dependencies
  pip3 install -r requirements.txt &>>log_file
  SYSTEMD_SETUP
}

GOLANG() {
  echo Installing GoLang
  dnf install golang -y &>>log_file
  APP_PREREQ
  echo Installing Dependencies
  go mod init dispatch &>>log_file
  go get &>>log_file
  go build &>>log_file
  SYSTEMD_SETUP
}