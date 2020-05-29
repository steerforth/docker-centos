#yum 源更换为网易源，并安装了常用软件 openssh-server、supervisor、vim、tar、wget、curl、rsync、bzip2、iptables、tcpdump、less、telnet、net-tools、lsof、sysstat、cron
FROM hub.c.163.com/public/centos:7.2-tools

MAINTAINER steerforth "565355716@qq.com"

##安装python3.6.8
#1.安装pip
RUN yum -y install epel-release
 
RUN yum -y install python-pip

RUN pip install --upgrade pip

#安装gcc, make命令
RUN yum -y install gcc

RUN yum -y install gcc automake autoconf libtool make

#2.安装相关依赖包
RUN yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel

#3.安装
RUN wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz

RUN mkdir /usr/local/python3

RUN tar -xf Python-3.6.8.tar.xz -C /usr/local/python3

RUN cd /usr/local/python3/Python-3.6.8 && ./configure --prefix=/usr/local/python3 && make && make install

#RUN make && make install

#4.创建软链接
#原来的python2备份 mv /usr/bin/python /usr/bin/python2 ,若已存在删除 
RUN rm -f /usr/bin/python

RUN ln -s /usr/local/python3/bin/python3 /usr/bin/python
#原来的pip2备份 mv /usr/bin/pip /usr/bin/pip2,若已存在删除
RUN rm -f /usr/bin/pip

RUN ln -s /usr/local/python3/bin/pip3 /usr/bin/pip

#5.修改原来支持python2的程序的启动文件
ADD yum /usr/bin/
ADD supervisorctl /usr/bin/
ADD supervisord /usr/bin/

ENTRYPOINT ["/usr/bin/supervisord"]