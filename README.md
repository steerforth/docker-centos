#hub.c.163.com/public/centos  7.2版本
##安装python3.6.8
#1.安装pip
yum -y install epel-release
 
yum -y install python-pip

pip install --upgrade pip

#安装gcc, make命令
yum -y install gcc

yum -y install gcc automake autoconf libtool make

#2.安装相关依赖包
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel

#3.安装
wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz

mkdir /usr/local/python3

tar -xf Python-3.6.8.tar.xz -C /usr/local/python3

cd /usr/local/python3/Python-3.6.8

./configure --prefix=/usr/local/python3

make 

make install

#4.创建软链接
#原来的python2备份 mv /usr/bin/python /usr/bin/python2 ,若已存在删除 
rm /usr/bin/python

ln -s /usr/local/python3/bin/python3 /usr/bin/python
#原来的pip2备份 mv /usr/bin/pip /usr/bin/pip2,若已存在删除
rm /usr/bin/pip

ln -s /usr/local/python3/bin/pip3 /usr/bin/pip


#5.centos ,yum源使用的是Python2.7,替换为Python3后，yum无法工作，需要修改yum配置文件
vi /usr/bin/yum
#将   #!/usr/bin/python改为#!/usr/bin/python2.7  保存


#6.supervisord
vi /usr/bin/supervisord
vi /usr/bin/supervisorctl
#将   #!/usr/bin/python改为#!/usr/bin/python2.7  保存


#7.保存镜像
sudo docker commit -a "steerforth" -m "centos python3.6.8" 容器id steer/centos:v1

