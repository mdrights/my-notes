
Centos下MySQL使用总结

时间:2013-08-17 17:00来源:quanpower 作者:本站 举报 点击:次


一、MySQL安装

   

 Centos下安装mysql 请点开:http://www.centoscn.com/CentosServer/sql/2013/0817/1285.html

二、MySQL的几个重要目录

 

    MySQL安装完成后不象SQL Server默认安装在一个目录，它的数据库文件、配置文件和命令文件分别在不同的目录，了解这些目录非常重要，尤其对于Linux的初学者，因为 Linux本身的目录结构就比较复杂，如果搞不清楚MySQL的安装目录那就无从谈起深入学习。　　

下面就介绍一下这几个目录。　　
2.1、数据库目录　　

/var/lib/mysql/ 　　
2.2、配置文件　　

/usr/share/mysql（mysql.server命令及配置文件）　　
2.3、相关命令　　

/usr/bin(mysqladmin mysqldump等命令) 　　
2.4、启动脚本　　

/etc/rc.d/init.d/（启动脚本文件mysql的目录）


三、登录MySQL 

3.1、连接本机MySQL

    例1：连接到本机上的MYSQL。

        首先在打开DOS窗口，然后进入目录 mysqlbin，再键入命令mysql -uroot -p，回车后提示你输密码，如果刚安装好MYSQL，超级用户root是没有密码的，故直接回车即可进入到MYSQL中了，MYSQL的提示符 是：mysql>。
3.2、连接远程MySQL

    例2：连接到远程主机上的MYSQL。假设远程主机的IP为：110.110.110.110，用户名为root,密码为abcd123。则键入以下命令：

        mysql -h110.110.110.110 -uroot -pabcd123

        （注:u与root可以不用加空格，其它也一样）
3.3、退出MYSQL

命令： exit （回车）。

四、修改登录密码　　

   

    MySQL默认没有密码，安装完毕增加密码的重要性是不言而喻的。

格式：mysqladmin -u用户名 -p旧密码 password 新密码
4.1、首次改密码

例1：给root加个密码ab12。首先在DOS下进入目录mysqlbin，然后键入以下命令：

        mysqladmin -uroot -password ab12

        注：因为开始时root没有密码，所以-p旧密码一项就可以省略了。
4.2、再次改密码

例2：再将root的密码改为djg345。

        mysqladmin -uroot -pab12 password djg345

五、增加用户

    

    （注意：和上面不同，下面的因为是MySQL环境中的命令，所以后面都带一个分号作为命令结束符）

        格式：grant select on 数据库.* to 用户名@登录主机 identified by \"密码\"

        例1、增加一个用户test1密码为abc，让他可以在任何主机上登录，并对所有数据库有查询、插入、修改、删除的权限。首先用以root用户连入MySQL，然后键入以下命令：

        grant select,insert,update,
        delete on *.* to test1@\"%\" Identified by \"abc\";

        但例1增加的用户是十分危险的，你想如某个人知道test1的密码，那么他就可以在internet上的任何一台电脑上登录你的MySQL数据库并对你的数据可以为所欲为了，解决办法见例2。

        例2、增加一个用户test2密码为abc,让他只可以在localhost上登录，并可以对数据库mydb进行查询、插入、修改、删除的操作 （localhost指本地主机，即MySQL数据库所在的那台主机），这样用户即使用知道test2的密码，他也无法从internet上直接访问数据 库，只能通过MySQL主机上的web页来访问。

        grant select,insert,update,
        delete on mydb.* to test2@localhost identified by \"abc\";

        如果你不想test2有密码，可以再打一个命令将密码消掉。

        grant select,insert,update,delete on mydb
        .* to test2@localhost identified by \"\";　

    用新增的用户如果登录不了MySQL，

在登录时用如下命令：　　mysql -u user_1 -p　-h 192.168.113.50　（-h后跟的是要登录主机的ip地址）　


六、启动与停止　　


6.1、启动　　

MySQL安装完成后启动文件mysql在/etc/init.d目录下，在需要启动时运行下面命令即可。　　

[root@test1 init.d]# /etc/init.d/mysql start 　　
6.2、停止　　

/usr/bin/mysqladmin -u root -p shutdown 　　
6.3、自动启动　　
6.3.1、察看mysql是否在自动启动列表中　　

[root@test1 local]#　/sbin/chkconfig –list 　　
6.3.2、把MySQL添加到你系统的启动服务组里面去　　

[root@test1 local]#　/sbin/chkconfig　– add　mysql 　　
6.3.3、把MySQL从启动服务组里面删除。　　

[root@test1 local]#　/sbin/chkconfig　– del　mysql


七、更改MySQL目录　　


    MySQL默认的数据文件存储目录为/var/lib/mysql。

假如要把目录移到/home/data下需要进行下面几步：　　
7.1、home目录下建立data目录　　

cd /home 　　mkdir data 　　
7.2、把MySQL服务进程停掉： 　　

mysqladmin -u root -p shutdown 　　
7.3、把/var/lib/mysql整个目录移到/home/data 　　

mv /var/lib/mysql　/home/data/ 　　

这样就把MySQL的数据文件移动到了/home/data/mysql下　　
7.4、找到my.cnf配置文件　　

如果/etc/目录下没有my.cnf配置文件，请到/usr/share/mysql/下找到*.cnf文件，拷贝其中一个到/etc/并改名为my.cnf)中。

命令如下：　　

[root@test1 mysql]# cp /usr/share/mysql/my-medium.cnf　/etc/my.cnf 　　
7.5、编辑MySQL的配置文件/etc/my.cnf 　　

为保证MySQL能够正常工作，需要指明mysql.sock文件的产生位置。

修改socket=/var/lib/mysql/mysql.sock一行中等号右边的值为：/home/mysql/mysql.sock 。

操作如下：　　

vi　 my.cnf　　　

(用vi工具编辑my.cnf文件，找到下列数据修改之) 　　

# The MySQL server 　　　 [mysqld] 　　　

port　　　= 3306 　　　

#socket　 = /var/lib/mysql/mysql.sock（原内容，为了更稳妥用“#”注释此行）　　　

socket　 = /home/data/mysql/mysql.sock　　　（加上此行）　　
7.6、修改MySQL启动脚本/etc/rc.d/init.d/mysql 　　

最后，需要修改MySQL启动脚本/etc/rc.d/init.d/mysql，把其中datadir=/var/lib/mysql一行中，等号右边的路径改成你现在的实际存放路径：home/data/mysql。　　

[root@test1 etc]# vi　/etc/rc.d/init.d/mysql 　　

#datadir=/var/lib/mysql　　　　（注释此行）　　

datadir=/home/data/mysql　　 （加上此行）　　
7.7、重新启动MySQL服务　　

/etc/rc.d/init.d/mysql　start 　　

或用reboot命令重启Linux 　　

如果工作正常移动就成功了，否则对照前面的7步再检查一下。　　


八、MySQL的常用操作　　


注意：MySQL中每个命令后都要以分号；结尾。　
8.1、MySQL常用操作命令　
8.1.1、显示数据库列表：

        show databases;

        刚开始时才两个数据库：mysql和test。MySQL库很重要它里面有MYSQL的系统信息，我们改密码和新增用户，实际上就是用这个库进行操作。
8.1.2、显示库中的数据表：

        use mysql； ／／打开库，学过FOXBASE的一定不会陌生吧

        show tables;
8.1.3、显示数据表的结构：

        describe 表名;
8.1.4、建库：

        create database 库名;
8.1.5、建表：

        use 库名；

        create table 表名 (字段设定列表)；
8.1.6、删库和删表:

        drop database 库名;

        drop table 表名；
8.1.7、将表中记录清空：

        delete from 表名;
8.1.8、显示表中的记录：

        select * from 表名;
8.1.9、增加记录　　

例如：增加几条相关纪录。　　

mysql> insert into name values('','张三','男','1971-10-01'); 　　

mysql> insert into name values('','白云','女','1972-05-20'); 　　

可用select命令来验证结果。　　

mysql> select * from name; 　　

+----+------+------+------------+ 　　

| id | xm　 | xb　 | csny　　　 | 　　

+----+------+------+------------+ 　　

|　1 | 张三 | 男　 | 1971-10-01 | 　　

|　2 | 白云 | 女　 | 1972-05-20 | 　　

+----+------+------+------------+ 　　
8.1.10、修改纪录　　

例如：将张三的出生年月改为1971-01-10 　　

mysql> update name set csny='1971-01-10' where xm='张三'; 　　
8.1.11、删除纪录　　

例如：删除张三的纪录。　　

mysql> delete from name where xm='张三'; 　　

8.2、一个建库和建表以及插入数据的实例

        drop database if exists school; //如果存在SCHOOL则删除

        create database school; //建立库SCHOOL

        use school; //打开库SCHOOL

        create table teacher //建立表TEACHER

        (

        id int(3) auto_increment not null primary key,

        name char(10) not null,

        address varchar(50) default ’深圳’,

        year date

        ); //建表结束

        //以下为插入字段

        insert into teacher values(’’,’glchengang’,’深圳一中’,’1976-10-10’);

        insert into teacher values(’’,’jack’,’深圳一中’,’1975-12-23’);

        注：在建表中（1）将ID设为长度为3的数字字段:int(3)并让它每个记录自动加一:auto_increment并不能为空:not null而且让他成为主字段primary key（2）将NAME设为长度为10的字符字段（3）将ADDRESS设为长度50的字符字段，而且缺省值为深圳。varchar和char有什么区别 呢，只有等以后的文章再说了。（4）将YEAR设为日期字段。

        如果你在MySQL提示符键入上面的命令也可以，但不方便调试。你可以将以上命令原样写入一个文本文件中假设为school.sql，然后复制到c:\\下，并在DOS状态进入目录\\mysql\\bin，然后键入以下命令：

        mysql -uroot -p密码 < c:\\school.sql

        如果成功，空出一行无任何显示；如有错误，会有提示。（以上命令已经调试，你只要将//的注释去掉即可使用）。


九 、修改数据库结构


9.1、字段操作
9.1.1、增加字段

alter table dbname add column <字段名><字段选项>
9.1.2、修改字段

alter table dbname change <旧字段名> <新字段名><选项>
9.1.3、删除字段

alter table dbname drop column <字段名>


十、数据导出


    数据导出主要有以下几种方法：

　　使用select into outfile "filename"语句

　　使用mysqldump实用程序
10.1、使用select into outfile "filename"语句

可以在mysql的命令行下或在php程序中执行它。我下面以在mysql命令行下为 例。在php中使用时，将其改成相应的查询进行处理即可。不过在使用这个命令时，要求用户拥有file的权限。如我们有一个库为phptest，其中有一 个表为driver。现在要把driver卸成文件。执行命令：

　　mysql> use phptest;

　　Database Changed

　　mysql> select * from driver into outfile "a.txt";

　　Query OK, 22 rows affected (0.05 sec)

上面就可以完成将表driver从数据库中卸到a.txt文件中。注意文件名要加单引 号。那么这个文件在哪呢？在mysql目录下有一个data目录，它即是数据库文件所放的地方。每个库在单独占一个子目录，所以phptest的目录为 c:\mysql\data\phptest(注意：我的mysql安装在c:\mysql下)。好，现在我们进去，a.txt就是它。打开这个文件，可 能是：

　　1 Mika Hakinnen 1

　　2 David Coulthard 1

　　3 Michael Schumacher 2

　　4 Rubens Barrichello 2

　　...

可能还有很多记录。每个字段之间是用制表符分开的(\t)。那么我们可以修改输出文件 名的目录，以便放在指定的位置。如"a.txt"可以改成"./a.txt"或"/a.txt"。其中"./a.txt"放在c:\mysql\data 目录下了，而"/a.txt"文件则放在c:\目录下了。所以select命令认为的当前目录是数据库的存放目录，这里是c:\mysql\data。

使用select命令还可以指定卸出文件时，字段之间的分隔字符，转义字符，包括字符，及记录行分隔字符。列在下面：

　　FIELDS

　　TERMINATED BY "\t"

　　[OPTIONALLY] ENCLOSED BY ""

　　ESCAPED BY ""

　　LINES

　　TERMINATED BY "\n"


　　TERMINATED 表示字段分隔


　　[OPTIONALLY] ENCLOSED 表示字段用什么字符包括起来，如果使用了OPTIONALLY则只有CHAR和VERCHAR被包括ESCAPED 表示当需要转义时用什么作为转义字符LINES TERMINATED 表示每行记录之间用什么分隔上面列的是缺省值，而且这些项都是可选的，不选则使用缺省值。可以根据需要进行修改。给出一个例子如下：

　　mysql> select * from driver into outfile "a.txt" fields terminated by ","

　　enclosed by """;

　　Query OK, 22 rows affected (0.06 sec)

结果可能如下：

　　"1","Mika","Hakinnen","1"

　　"2","David","Coulthard","1"

　　"3","Michael","Schumacher","2"

　　"4","Rubens","Barrichello","2"

　　...

可以看到每个字段都用","进行了分隔，且每个字段都用"""包括了起来。注意，行记录分隔符可以是一个字符串，请大家自行测试。不过，如果输出文件在指定目录下如果存在的话就会报错，先删除再测试即可。
10.2、使用mysqldump实用程序

从上面的select方法可以看出，输出的文件只有数据，而没有表结构。而且，一次只 能处理一个表，要处理多个表则不是很容易的。不过可以将select命令写入一个sql 文件（复制文本应该是很容易的吧），然后在命令行下执行即可：mysql 库名先来个最简单的吧：

mysqldump phptest > a.sql

可能结果如下：

　　# MySQL dump 7.1

　　#

　　# Host: localhost Database: phptest

　　#--------------------------------------------------------

　　# Server version 3.22.32-shareware-debug

　　#

　　# Table structure for table "driver"

　　#

　　CREATE TABLE driver (

　　drv_id int(11) DEFAULT "0" NOT NULL auto_increment,

　　drv_forename varchar(15) DEFAULT "" NOT NULL,

　　drv_surname varchar(25) DEFAULT "" NOT NULL,

　　drv_team int(11) DEFAULT "0" NOT NULL,

　　PRIMARY KEY (drv_id)

　　);

　　#

　　# Dumping data for table "driver"

　　#


　　INSERT INTO driver VALUES (1,"Mika","Hakinnen",1);

　　INSERT INTO driver VALUES (2,"David","Coulthard",1);

　　INSERT INTO driver VALUES (3,"Michael","Schumacher",2);

　　INSERT INTO driver VALUES (4,"Rubens","Barrichello",2);

　　...


　　如果有多表，则分别列在下面。可以看到这个文件是一个完整的sql文件，如果要将 其导入到其它的数据库中可以通过命令行方式，很方便：mysql phptest < a.sql。如果将数据从本地传到服务器上，则可以将这个文件上传，然后在服务器通过命令行方式装入数据。

如果只想卸出建表指令，则命令如下：

　　mysqldump -d phptest > a.sql

如果只想卸出插入数据的sql命令，而不需要建表命令，则命令如下：

　　mysqldump -t phptest > a.sql

那么如果我只想要数据，而不想要什么sql命令时，应该如何操作呢？

　　mysqldump -T./ phptest driver

其中，只有指定了-T参数才可以卸出纯文本文件，表示卸出数据的目录，./表示当前目 录，即与mysqldump同一目录。如果不指定driver表，则将卸出整个数据库的数据。每个表会生成两个文件，一个为.sql文件，包含建表执行。 另一个为.txt文件，只包含数据，且没有sql指令。

对卸出的数据文件，也可以同select方法一样，指定字段分隔符，包括字符，转义字段，行记录分隔符。参数列在下面：

　　--fields-terminated-by= 字段分隔符

　　--fields-enclosed-by= 字段包括符

　　--fields-optionally-enclosed-by= 字段包括符，只用在CHAR和VERCHAR字段上

　　--fields-escaped-by= 转义字符

　　--lines-terminated-by= 行记录分隔符

我想大家应该明白这些参数的意思了吧。一个例子如下：

　　mysqldump -T./ --fields-terminated-by=, --fields-enclosed-by=" phptest driver

输出结果为：

　　"1","Mika","Hakinnen","1"

　　"2","David","Coulthard","1"

　　"3","Michael","Schumacher","2"

　　"4","Rubens","Barrichello","2"

　　...

请注意字符的使用。
10.3、小结

以上为使用select和mysqldump实用程序来卸出文本的方法。select适合利用程序进行处理，而mysqldump则为手工操作，同时提供强大的导出功能，并且可以处理整个库，或库中指定的多表。大家可以根据需求自行决定使用。

同时还有一些方法，如直接数据库文件拷贝也可以，但是移动后的数据库系统与原系统应一致才行。这里就不再提了。


十一、数据导入


同导出相类似，导入也有两种方法：

　　使用LOAD DATA INFILE "filename"命令

　　使用mysqlimport实用程序

　　使用sql文件

由于前两个处理与导出处理相似，只不过是它们的逆操作，故只给出几种命令使用的例子，不再解释了，大家可以自行查阅手册。
11.1、使用load命令：

　　load data infile "driver.txt" into table driver fields terminated by ","

　　enclosed by """;
11.2、使用mysqlimport实用程序：

　　mysqlimport --fields-terminated-by=, --fields-enclosed-by=" phptest driver.txt
11.3、使用SQL文件

    则可以使用由mysqldump导出的sql文件，在命令行下执行mysql库名。

首先要声明一点，大部分情况下，修改MySQL是需要有mysql里的root权限的，所以一般用户无法更改密码，除非请求管理员。

方法一

使用phpmyadmin，这是最简单的了，修改mysql库的user表，不过别忘了使用PASSWORD函数。

方法二

使用mysqladmin，这是前面声明的一个特例。

mysqladmin -u root -p password mypasswd

输入这个命令后，需要输入root的原密码，然后root的密码将改为 mypasswd。把命令里的root改为你的用户名，你就可以改你自己的密码了。当然如果你的mysqladmin连接不上mysql server，或者你没有办法执行mysqladmin，那么这种方法就是无效的。而且mysqladmin无法把密码清空。

下面的方法都在mysql提示符下使用，且必须有mysql的root权限：

方法三

　　mysql> INSERT INTO mysql.user (Host,User,Password)

　　VALUES('%','jeffrey',PASSWORD('biscuit'));

　　mysql> FLUSH PRIVILEGES

确切地说这是在增加一个用户，用户名为jeffrey，密码为biscuit。在《mysql中文使用手册》里有这个例子，所以我也就写出来了。注意要使用PASSWORD函数，然后还要使用FLUSH PRIVILEGES。

方法四

和方法三一样，只是使用了REPLACE语句

　　mysql> REPLACE INTO mysql.user (Host,User,Password)

　　VALUES('%','jeffrey',PASSWORD('biscuit'));

　　mysql> FLUSH PRIVILEGES

方法五

使用SET PASSWORD语句，

mysql> SET PASSWORD FOR jeffrey@"%" = PASSWORD('biscuit');

拟也必须使用PASSWORD()函数，但是不需要使用FLUSH PRIVILEGES。

方法六

使用GRANT ... IDENTIFIED BY语句

mysql> GRANT USAGE ON *.* TO jeffrey@"%" IDENTIFIED BY 'biscuit';

这里PASSWORD()函数是不必要的，也不需要使用FLUSH PRIVILEGES。

注意： PASSWORD() [不是]以在Unix口令加密的同样方法施行口令加密。

MySQL 忘记口令的解决办法

如果 MySQL 正在运行，首先杀之： killall -TERM mysqld。

启动 MySQL ：bin/safe_mysqld --skip-grant-tables &就可以不需要密码就进入 MySQL 了。然后就是

　　>use mysql

　　>update user set password=password("new_pass") where user="root";

　　>flush privileges;

重新杀 MySQL ，用正常方法启动 MySQL 。


十二、备份与恢复　　
12.1、备份　　

例如：将上例创建的aaa库备份到文件back_aaa中　　

[root@test1 root]# cd　/home/data/mysql　(进入到库目录，本例库已由val/lib/mysql转到/home/data/mysql，见上述第七部分内容) 　　

[root@test1 mysql]# mysqldump -u root -p --opt aaa > back_aaa 　　
12.2、恢复　　

[root@test mysql]# mysql -u root -p ccc < back_aaa


十三、mysqladmin 公用程式的使用


mysqladmin 公用程式可用来维护 MySQL 比较一般性的工作（新增、删除资料库、设定使用者密码及停止 MySQL 等等），详细的说明可以使用 mysqladmin --help 来查看。（以本文的安装为例 mysqladmin 位於 /usr/local/mysql/bin/mysqladmin）。

新增资料库 dbtest

# /usr/local/mysql/bin/mysqladmin -u root -p create dbtest

Enter password:

Database "dbtest" created.

删除资料库

# /usr/local/mysql/bin/mysqladmin -u root -p drop dbtest

Enter password:

Dropping the database is potentially a very bad thing to do.

Any data stored in the database will be destroyed.


Do you really want to drop the 'dbtest' database [y/N]

y

Database "dbtest" dropped

设定使用者密码（将 maa 的密码改为 7654321，mysqladmin 会先询问 maa 的原密码）

# /usr/local/mysql/bin/mysqladmin -u maa -p password 7654321

Enter password:

#

停止 MySQL 服务

# ./mysqladmin -u root -p shutdown

Enter password:

注意，shutdown MySQL 后，必须由作业系统的 root 帐号执行下列指令才能启动 MySQL：

/usr/local/mysql/share/mysql/mysql.server start
修改MYSQL的默认编码
MySQL的默认编码是Latin1，不支持中文，那么如何修改MySQL的默认编码呢，下面以UTF-8为例来说明需要注意的是，要修改的地方非常多，相应的修改方法也很多。下面是一种最简单最彻底的方法：Windows系统 
1、中止MySQL服务 
2、在MySQL的安装目录下找到my.ini，如果没有就把my-medium.ini复制为一个my.ini即可 
3、打开my.ini以后，在[client]和[mysqld]下面均加上default-character-set=utf8，保存并关闭 
4、启动MySQL服务

------分隔线----------------------------

    上一篇：建立Centos两用户之间的信任关系
    下一篇：Linux高手的 20 个习惯

    收藏 举报 推荐 打印 

发表评论
    为了和诣的生活，我关闭了评论页面，请大家到QQ群里交流吧：348944156,也欢迎关注本站微信公众号：centoscn 

栏目分类

            基础命令
            系统配置
            中级进介

本月热点

        Centos下MySQL使用总结
        CentOS7下Firewall防火墙配置用
        Centos下软件的安装与卸载方法
        Centos远程登录三种方式telnet，
        Centos 文件和目录访问权限设置
        CentOS7.0的几个新特性
        CentOS下php.ini配置文件详解
        浅谈Centos用户权限管理
        CentOS开机启动服务的修改与查看
        CentOS服务器最新分区方案

推荐内容

        CentOS 6.5 LVM磁盘管理学习

        ...
        XE+kickstart下自动安装centOS6.5

        ...
        Centos6.6系统root用户密码恢复案例

        ...
        CentOS6.6服务器之间文件共享挂载

        ...
        centos rm -rf 恢复删除的文件

        CentOS有时候执行了 rm -rf 等操作误删了文件绝对是一件可怕的事情，好在有一些解决的...

关于我们 - 联系我们 - 广告服务 - 免责申明 - 版权申明 - TAG标签 - 网站地图 - 返回顶部

Copyright 2012-2013(CentOS中文网) CentOScn.Com 粤ICP备13006404号 Powered by DedeCMS 1.0
