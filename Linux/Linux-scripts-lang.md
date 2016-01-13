
Linux和Windows上流行的脚本语言

2013-6-7 10:52    评论: 3    

文章地址：https://linux.cn/article-1449-1.html

具备脚本知识的系统管理员与其他系统管理员有着明显的区别。

脚本是一门“系统管理员”创造的艺术。这门艺术需要了解系统本身的相关知识，系统管理命令的语法，编程和算法知识以及至少一门脚本编程语言。对系统管理员来说编写脚本有很多选择，每种脚本语言都有着自己独特的语法和优点。脚本语言之间几乎没有相似之处，但也不会像外星语那样难以读懂。脚本语言既可用来管理系统，也可以用做web开发。有基于服务端，也有基于客户端的脚本语言。客户端脚本语言大多数用来在浏览器里显示内容以及与用户进行交互。服务器端脚本语言通常用来管理系统或web服务。

本文中，我们只会关注那些用作系统管理的脚本语言。让我们开始吧！

关于脚本应该知道的事情：

• 脚本应该可以作为独立的命令执行，或者可以在终端命令行接口下使用脚本语言的二进制文件调用。

• 如果是可执行脚本，应该在开头写出下面这行特殊的代码：

#!/path/of/the/cli

例如bash

#!/bin/bash

或者perl

#!/usr/bin/perl

‘#!’这个符号代表了执行该脚本需要调用的程序。

Bash

在Linux和UNIX世界里，bash脚本的数量最多。正如我们在很多文章中提到的那样，bash也是最受到大家喜爱的。

基本上，bash是一个具有解释功能的命令行shell。它能够用作编程并且满足大多数的基本编程需求。在使用变量之前无需声明，也不需要知道变量的类型。它的缺点在于，使用bash没有其他的库可以利用。你可以使用的只有/bin/bash （或 /bin/sh）。当你声明一个变量时，你无需在前面使用$符号，但是在使用时你需要在前面加上$表明它是一个“变量”。

bash非常容易编写，Linux、UNIX以及安装了cgywin程序的Windows都带有bash。如果你身为一名系统管理员但是不会bash脚本编程，你最好马上开始学习。《10本适合于系统管理员的最佳书籍》这篇文章里列举了很多好的参考书。下面是一段简单的bash脚本。

#!/bin/bash
 
USER=$1
echo "Adding User $USER in group users..."
/usr/sbin/useradd -g users $USER
if [ $? == 0 ]; then
        /usr/bin/passwd $USER
else
        echo "Sorry, User addition failed"
fi

Perl

基本上，perl可以看做UNIX和Windows系统上的（图灵）完备编程语言。perl的含义是实用报表提取语言（Practical Extraction and Report Language）。Perl是一种通用编程语言，起初开发perl是用于文字处理，现在的使用范围非常广泛，包括系统管理、web开发、网络编程、甚至GUI开发等许多场合。

它的优点是易于使用且同时支持面向过程和面向对象编程。perl是模块化的，易于调用第三方模块。尽管设计的目标是图灵完备的编程语言，但是自1993年面世开始perl一直被用作编写系统管理脚本。perl既支持编译也可以解释执行，因此perl比bash脚本更安全。当错误发生时，bash脚本并不知道；然而，如果在执行之前编译过程中有任何错误发生perl会拒绝启动执行。

一段小的perl脚本会让你体会perl语言的风格。#之后的内容是注释。这段脚本会创建一个包含1000个随机数的数组，每个随机数包含16个数字：

#!/usr/bin/perl
 
my @numbers;
srand (time);
 
for ($i=0; $i<1000; $i++)
{
$a=int 10000000000*rand();
$b=int 10000000000*rand();
$c = $a . $b;
 
push @numbers,substr($c,0,16)."\n";
}
print @numbers;

PHP

大家都知道PHP“通常”被用作web网站开发，但是它也可以像perl一样执行系统管理任务。这就是为什么很多系统管理员使用PHP完成cron任务和其他脚本工作。虽然与perl功能相似，但是PHP的目标是生成HTML标准输出。通常它会被嵌入在web服务器程序中运行。命令行版本的PHP支持脚本编程。

类似上面perl示例，同样功能的PHP脚本如下：

#!/usr/bin/php
 
function make_seed()
{
 
list($usec, $sec) = explode(' ', microtime());
 
return (float) $sec + ((float) $usec * 100000);
}
 
srand (make_seed());
 
for ($i=0; $i<1000; $i++)
{
$a=rand(1000000000,9999999999);
$b=rand(1000000000,9999999999);
$c = $a . $b;
 
$numbers[]=substr($c,0,16);
}
for ($i=0; $i<1000;$i++)
 
echo "$numbers[$i]\n";

Python

很明显，我们是在讨论脚本语言而不是亚马逊丛林里的某种动物。python是通用高级编程语言，它强调代码的可读性。python的语法非常简洁且富有表现力。与perl类似，python也有很多的扩展库。尽管python具备函数式编程的能力，但是大多数时候它被看作一门面向对象语言。web开发方面，python被用来开发Apache项目的mod_wsgi模块。如今，大多数Linux和UNIX发行版本都包含了python，作为脚本语言的一种很多系统工具采用python进行开发。python也支持为GUI环境编写代码。

下面是一段简单的python代码：

health = 10
trolls = 0
damage = 3
 
while health >0:        #!= 0:
  trolls += 1
  health = health - damage
  print " " ,"but takes", damage, "damage points.\n"
  print " ", trolls, "trolls."

sed

sed是一个Unix文本解析工具，它提供一种编程语言可用来对文本解析和转换。sed是流编辑器（Stream Editor）的缩写，基本上是一个运行飞快的文本编辑器。sed不提供任何交互环境进行文件编辑。它逐行读取内容，对读取的内容执行命令行指定的操作即sed脚本，然后输出执行结果。你可以对文件用sed快速执行文本操作。最近perl被用来处理同样的工作，但是仍然有一些情形需要由专家级系统管理员使用sed快速解决任务。下面是一个简单的示例：
$ sed -e 's/foo/bar/g' myfile.txt

这个命令会查找myfile.txt文件中所有的foo并替换成bar然后把结果输出到屏幕上。sed的主要命令是 ‘s/foo/bar/g’，该命令在vi或vim在交互式编辑模式下同样支持。

除了本文介绍的这些之外，还有像Ruby、VBScript、Java Script、JScript、Tcl、AppleScript和Falcon等等很多其他的脚本语言。本文旨在介绍那些在系统管理中常用的脚本语言，希望你能够熟悉它们并提升你的工作效率。

 

英文原文 iSystemAdmin  编译：伯乐在线 – 唐尤华

