source ./common.sh
app_name=catalogue

cp $app_name.service /etc/systemd/system/$app_name.service
cp mongo.repo /etc/yum.repos.d/mongo.repo

NODEJS

systemctl daemon-reload
systemctl enable $app_name
systemstl start $app_name

dnf install mongodb-mongosh -y

mongosh --host mongodb-dev.pavanidevops.online </app/db/master-data.js

