echo -e "\e[32m disable nodejs \e[0m"
dnf module disable nodejs -y

echo -e "\e[32m enable nodejs \e[0m"
dnf module enable nodejs:18 -y

echo -e "\e[32m install nodejs \e[0m"
dnf install nodejs -y

echo -e "\e[32m copy backend.service file \e[0m"
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[32m adding user \e[0m"
useradd expense

echo -e "\e[32m create app directory \e[0m"
mkdir /app

echo -e "\e[32m download backend.zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip

echo -e "\e[32m app directory \e[0m"
cd /app

echo -e "\e[32m install dependencies \e[0m"
npm install

echo -e "\e[32m intall mysql \e[0m"
dnf install mysql -y

echo -e "\e[32m set uname and passwd \e[0m"
mysql -h mysql-dev.vaddi.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

echo -e "\e[32m  daemon-reload \e[0m"
systemctl daemon-reload

echo -e "\e[32m restart nginx \e[0m"
systemctl enable backend
systemctl restart backend