log_file = /tmp/expense.log
color = "\e[34m"


echo -e "${color} Disable mysql \e[0m"
dnf module disable mysql -y &>>log_file
echo $?

echo -e "${color} copy repo fiule \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
echo $?

echo -e "${color} installing mysql client server \e[0m"
dnf install mysql-community-server -y &>>log_file
echo $?

echo -e "\${color} restart mysql \e[0m"
systemctl enable mysqld &>>log_file
systemctl restart mysqld &>>log_file
echo $?

echo -e "\${color} mysql root pass \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file
echo $?