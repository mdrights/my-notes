Apache使用详解
[日期：2014-08-10] 	来源：Linux社区  作者：dddbk 	[字体：大 中 小]

Apache是世界使用排名第一的Web服务器软件。它可以运行在几乎所有广泛使用的计算机平台上，由于其跨平台和安全性被广泛使用，是最流行的Web服务器端软件。接下来，我们通过一系列实验，来对其有一个更加深入的了解。

--------------------------------------分割线 --------------------------------------

Ubuntu 13.04 安装 LAMP\Vsftpd\Webmin\phpMyAdmin 服务及设置 http://www.linuxidc.com/Linux/2013-06/86250.htm

CentOS 5.9下编译安装LAMP(Apache 2.2.44+MySQL 5.6.10+PHP 5.4.12) http://www.linuxidc.com/Linux/2013-03/80333p3.htm

RedHat 5.4下Web服务器架构之源码构建LAMP环境及应用PHPWind http://www.linuxidc.com/Linux/2012-10/72484p2.htm

LAMP源码环境搭建WEB服务器Linux+Apache+MySQL+PHP http://www.linuxidc.com/Linux/2013-05/84882.htm

LAMP+Xcache 环境搭建 http://www.linuxidc.com/Linux/2014-05/101087.htm

--------------------------------------分割线 --------------------------------------

1.通过yum安装httpd服务

[root@wh1 ~]# yum install httpd


2.配置文件全局配置配置信息详解

1) 配置持久连接

KeepAlive <On|Off> #是否开启持久连接功能

MaxKeepAliveRequest 100 #一次持久连接最大的请求个数

KeepAliveTimeout 15 #持久连接的超时时间

2) 配置监听IP和端口

Listen [IP:]Port #设置监听的IP地址以及端口，本选项可以指定多个，以支持监听多个IP及端口

3) 模块动态装卸载

LoadModule ModuleName /path/to/module

#可以在终端使用如下命令查看已装载的模块

[root@wh1 ~]# httpd -D DUMP_MODULES

Loaded Modules:

 core_module (static)

 mpm_prefork_module (static)

 ......

 dnssd_module (shared)

 php5_module (shared)

 ssl_module (shared)

Syntax OK

4) 指定站点根目录

DocumentRoot /path/to/documentroot #定义网页文件所在的目录

5) 定义默认主页信息

DirectoryIndex index.html index.php .... #各参数之间以空格分割

6) 路径别名

Alias url/ /path/ #注意，末尾的“/”要保持一致，有则都有，无则均无

7) 默认字符集设置

AddDefaultCharset 字符集

#常用中文字符集有：GB2310,GB18030,GBK

#通用字符集：UTF-8,UTF-16

8) 配置支持CGI脚本

ScriptAlias /cgi-bin/ "/var/www/cgi-bin/" #将CGI脚本执行路径定义到指定路径

 <Directory "/var/www/cgi-bin"> #设置cgi脚本路径的访问控制，下方对其中参数有详细说明

    AllowOverride None

    Options None

    Order allow,deny

    Allow from all

</Directory>

3.访问控制

a) 基于IP地址的访问控制

Order allow,deny #默认拒绝所有

Order deny,allow #默认允许所有

Allow|Deny from {all|ipaddr|NetworkAddress}

其中Networkaddress格式可以为以下几种

172.16

            172.16.0.0

            172.16.0.0/16

                172.16.0.0 255.255.0.0


b) 基于用户认证的访问控制

#基于用户的访问认认证有basic和digest两种

#认证文件有文本文件:.htpasswd，SQL数据库，DBM:数据库引擎以及ldap

#下面我们以基于文本文件的basic认证来配置

#=========================================================

#1.确保基本认证模块已经加载

LoadModule auth_basic_module modules/mod_auth_basic.so

#2.创建认证文件,添加用户

#htpasswd FILE USERNAME

#-c：文件不存在时则创建文件

#-m：使用MD5加密密码

#-D：删除用户

[root@wh1 ~]# htpasswd -c -m /etc/httpd/.passwd test1

New password:

Re-type new password:

Adding password for user test1

[root@wh1 ~]# htpasswd  -m /etc/httpd/.passwd test2

New password:

Re-type new password:

Adding password for user test2

[root@wh1 ~]# cat /etc/httpd/.passwd

test1:$apr1$dgaArWEk$U04MnXH2HBRT/P5fUoj2P0

test2:$apr1$N4uhZ492$1L70450o982fZPQmbd594/

#3.为目录配置用户认证

[root@wh1 conf.d]# vim auth.conf

 

<Directory /var/www/html/auth>

    options none

    AllowOverride AuthConfig

    AuthType Basic  #定义认证类型

    AuthName "PLZ inout you user info" #定义认证提示信息

    AuthUserFile /etc/httpd/.passwd  #定义认证文件

    Require valid-user 

    #定义可访问用户，可以为vbalid-user表示文件中所有用户，也可使用user USERNAME 定义指定用户

</Directory>

4.日志功能

#错误日志定义

ErrorLog “path/to/error/logfile”

#定义错误日志级别

LogLevel {debug|info|notice|warn|error|crit|alert|emerg}

#自定义日志

CustomLog “/path/to/customlog/file” 日志格式名

#自定义日志格式定义

LogFormat “格式” 格式名

#格式中常用的宏

#%h:客户端地址

#%l:远程登录名

#%u:远程认证名称,没有认证为"-"

#%t:收到请求时间

#%r:请求报文的起始行

#%>s:响应状态吗

#%b:响应报文长度bits

#%{HEADER_NAME}i:记录指定首部对应的值

5.MPM参数配置

<IfModule prefork.c> #如果启用prefork模块，下列参数生效

StartServers 8#表示启动服务器时启动多少线程

MinSpareServers 5 #定义最小空闲进程数

MaxSpareServers 20 #定义最大空闲进程数

ServerLimit 256 #最大进程数

MaxClients 256 #最大客户端个数

MaxRequestsPerChild 4000 #每个进程允许在其生命周期处理多少请求

</IfModule>

#==========================

<IfModule worker.c>

StartServers 4 #表示启动服务器时启动多少线程

MaxClients 300 #最多客户端个数

MinSpareThreads 25 #最小空闲进程数

MaxSpareThreads 75 #最大空闲进程数

ThreadsPerChild 25 #每个进程生成多少线程

MaxRequestsPerChild 0 #每个进程允许在其生命收起处理多少请求

</IfModule>


6.虚拟主机

（篇幅较长，请看我的另外一篇博文 点击查看 http://www.linuxidc.com/Linux/2014-08/105384.htm ）

7.Apache内嵌处理器server-status使用

[root@wh1 conf.d]# cat serverstatus.conf

<Location /server-status>

options none

SetHandler server-status

Order allow,deny

allow from 192.168.1

</Location>

Apache使用详解

8.配置实用https协议实现安全连接

#安装mod_ssl

[root@wh1 conf.d]# yum install mod_ssl

#为httpd生成私钥并生成证书

mkdir /etc/httpd/ssl;cd httpd/ssl

(umask 077;openssl genrsa -out /etc/httpd//httpd.key 1024)

openssl req -new -key httpd.key -out httpd.csr

#在CA证书服务器上为其签署证书并传回给

openssl ca -in httpd.csr -out httpd.crt -days 1000

#配置ssl认证

SSLCertificateFile /etc/httpd/ssl/httpd.crt #指定证书位置

SSLCertificateKeyFile /etc/httpd/ssl/httpd.key #指定私钥位置

Apache使用详解

9.httpd自带工具使用

httpd:apache服务器程序

-t:测试

-l:列出静态模块

-D DUMP_MODULES:列出DSO模块

-M,相当于-t -DDUMP_MODUKLES

-D DUMP_VHOSTS:列出所有虚拟主机

htpasswd:为基于文件basic认证创建更新用户账号文件和认证文件

-c：创建文件，第一次添加用户使用

-m：用MD5加密

-d：删除用户

apachectl:httpd服务控制工具

ab:apache基准性能测试工具

ab [options] URL

-c #:并发数

-n #:总请求数

-n的值一定大于-c的值

-c #：指定并发数

-n #：指定总的请求数

10.通过源码安装httpd-2.4