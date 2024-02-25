log_file = /tmp/expense.log
color = "\e[32m"

echo -e  "${color} Disable nodejs \e[0m"
dnf module disable nodejs -y &>> log_file
echo $?

echo -e "${color} enable nodejs \e[0m"
dnf module enable nodejs:18 -y &>> log_file
echo $?

echo -e "${color} install nodejs \e[0m"
dnf install nodejs -y &>> log_file
echo $?

echo -e "${color} copy backend.service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>> log_file
echo $?

echo -e "${color} adding user \e[0m"
useradd expense &>> log_file
echo $?

echo -e "${color} create app directory \e[0m"
mkdir /app &>> log_file
echo $?

echo -e "${color} download backend.zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>> log_file
echo $?

echo -e "${color} app directory \e[0m"
cd /app
unzip /tmp/backend.zip &>> log_file
echo $?


echo -e "${color} install dependencies \e[0m"
npm install &>> log_file
echo $?

echo -e "${color} intall mysql \e[0m"
dnf install mysql -y &>> log_file
echo ?

echo -e "${color} set uname and passwd \e[0m"
mysql -h mysql-dev.vaddi.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> log_file
echo $?

echo -e "${color}  daemon-reload \e[0m"
systemctl daemon-reload &>> log_file
echo $?

echo -e "${color}restart nginx \e[0m"
systemctl enable backend &>>log_file
systemctl restart backend &>> log_file
echo $?