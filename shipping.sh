source ./common.sh
app_name=shipping

dnf install mysql -y

mysql -h mysql-dev.pavanidevops.online -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql-dev.pavanidevops.online -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h mysql-dev.pavanidevops.online -uroot -pRoboShop@1 < /app/db/master-data.sql

systemctl restart shipping

