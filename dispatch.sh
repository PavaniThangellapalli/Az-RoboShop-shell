dnf install golang -y

useradd roboshop

cp dispatch.service /etc/systemd/system/dispatch.service

rm -rf /app
mkdir /app

rm -f /tmp/dispatch.zip

curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip

go mod init dispatch
go get
go build

systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch
