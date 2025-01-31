source ./common.sh

echo Copying RabbitMQ repo file
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>log_file
Status_Print $?

echo Install RabbitMQ
dnf install rabbitmq-server -y &>>log_file
Status_Print $?

echo Start RabbbitMQ service
systemctl enable rabbitmq-server &>>log_file
systemctl start rabbitmq-server &>>log_file
Status_Print $?

echo Adding User
rabbitmqctl add_user roboshop roboshop123 &>>log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>log_file
Status_Print $?
