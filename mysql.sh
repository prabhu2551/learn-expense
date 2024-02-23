echo -e "\e[33m installing nginx \e[0m"
dnf module disable mysql -y

echo -e "\e[33m installing nginx \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[33m installing nginx \e[0m"
dnf install mysql-community-server -y

echo -e "\e[33m installing nginx \e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[33m installing nginx \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1