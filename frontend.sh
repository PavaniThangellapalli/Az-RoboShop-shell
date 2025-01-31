echo Disable nginx
dnf module disable nginx -y &>>log_file
Status_Print $?

echo Enable nginx
dnf module enable nginx:1.24 -y &>>log_file
Status_Print $?

echo Installing Nginx
dnf install nginx -y &>>log_file
Status_Print $?

echo Copying the Conf file
cp nginx.conf /etc/nginx/nginx.conf &>>log_file
Status_Print $?

echo Removing the default content
rm -rf /usr/share/nginx/html/* &>>log_file
Status_Print $?

echo Removing temp file
rm -f /tmp/frontend.zip &>>log_file
Status_Print $?

echo Downloading the Content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>log_file
Status_Print $?

echo Unzip the content
cd /usr/share/nginx/html/ &>>log_file
unzip /tmp/frontend.zip &>>log_file
Status_Print $?

echo Starting the nginx service
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
Status_Print $?


