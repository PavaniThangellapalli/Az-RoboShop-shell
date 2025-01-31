echo Installing MySQL
dnf install mysql-server -y &>>log_file
Status_Print $?

echo Starting the MySQL service
systemctl enable mysqld &>>log_file
systemctl restart mysqld &>>log_file
Status_Print $?

echo set MySQL Password
mysql_secure_installation --set-root-pass RoboShop@1 &>>log_file
Status_Print $?

