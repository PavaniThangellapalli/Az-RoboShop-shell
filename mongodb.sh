source ./common.sh

echo Copying MongoDB repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
Status_Print $?

echo Installing MongoDB
dnf install mongodb-org -y &>>log_file
Status_Print $?

echo Updating MongoDB Listen Address
sed -i 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf &>>log_file
Status_Print $?

echo Starting the MongoDB service
systemctl enable mongod &>>log_file
systemctl restart mongod &>>log_file
Status_Print $?
