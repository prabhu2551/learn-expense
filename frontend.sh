echo -e "\e[35m installing nginx \e[0m"
dnf install nginx -y

echo -e "\e[35m cp expense.config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[35m remove existing content \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35m download frontend content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[35m unzip the content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[35m Restarting nginx \e[0m"
systemctl enable nginx
systemctl restart nginx