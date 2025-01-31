source ./common.sh
app_name=user

cp user.service /etc/systemd/system/user.service
NODEJS

systemctl daemon-reload
systemctl enable user
systemctl start user
