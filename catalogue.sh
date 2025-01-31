app_name=catalogue

cp $app_name.service /etc/systemd/system/$app_name.service
cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

useradd roboshop

rm -rf /app
mkdir /app

rm -f /tmp/$app_name.zip

curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
cd /app
unzip /tmp/$app_name.zip
npm install

systemctl daemon-reload
systemctl enable $app_name
systemstl start $app_name

dnf install mongodb-mongosh -y

mongosh --host mongodb-dev.pavanidevops.online </app/db/master-data.js

