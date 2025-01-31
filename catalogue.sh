source ./common.sh
app_name=catalogue

NODEJS

echo Copying the MongoDB repo file
cp $dir_path/mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
Status_Print $?

echo Installing MongoDB
dnf install mongodb-mongosh -y &>>log_file
Status_Print $?

echo Loading the Master Data
mongosh --host mongodb-dev.pavanidevops.online </app/db/master-data.js &>>log_file
Status_Print $?

