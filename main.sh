#!bin/bash
#!/usr/bin/expect 

# alias sql ='mysql -uroot -plocaldb001'
# alias art ='php artisan'

# source ~/.bash_aliases

lnmpFile="/opt/lnmp1.4.tar.gz"
lnmpPath="/opt/"
phpPath="/usr/local/php"

if[! -x "$lnmpPath"]:then
	echo "directory no 777"
	chmod -R 777 .
fi


if [ -x -f "$lnmpFile"]; then 
   cd  /opt && tar -xvf lnmpFile && cd lnmp1.4
else
   wget -c http://soft.vpser.net/lnmp/lnmp1.4.tar.gz && tar zxf lnmp1.4.tar.gz && cd lnmp1.4
fi

echo "change fileinfo"

sed -i 's/--disable-fileinfo/--enable-fileinfo/g' php.sh
sed -i 's/--disable-fileinfo/--enable-fileinfo/g' upgrade_php.sh


echo "make config"
if [ -x -d "$lnmpPath"];then
	cd /opt/lnmp1.4 && ./install.sh
else
    chmod -R 777 .
    cd /opt/lnmp1.4 && ./install.sh
fi

if [-d "$phpPath"];then
	DIR="$( cd "$( dirname "$0"  )" && pwd  )"
	cp -f DIR/nginx.conf /usr/local/nginx/conf
	nginx -s reload
fi

echo "env bulid success"