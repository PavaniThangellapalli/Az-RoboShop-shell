source ./common.sh
app_name=cart

cp cart.service /etc/systemd/system/cart.service

NODEJS

systemctl daemon-reload
systemctl enable cart
systemctl start cart
