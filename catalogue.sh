source ./common.sh
app_name=catalogue

cp mongo.repo /etc/yum.repos.d/mongo.repo

NODEJS

dnf install mongodb-mongosh -y

mongosh --host mongodb-dev.pavanidevops.online </app/db/master-data.js

