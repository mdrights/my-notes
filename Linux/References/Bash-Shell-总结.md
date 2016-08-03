

脚本编程语言与编译型语言：

脚本编程语言：(Bash)  
   脚本编程语言通常是解释型(interpreted),主要由解释器(interpreter)读入程序代码，并将其转换成内部的形式加以执行。  
   优点：  
       能够轻易处理文件与目录之类的对象。  
   缺点：  
       运行效率通常不如编译型语言  
编译型语言：(C、C++、Java、Fortran、Ada、Pascal)  
   编译型语言多半运作于底层，所处理的是字节、整数、浮点数或其它及其机器层经的对象。

SHELL脚本的基本语法格式：

脚本必须以#!开头：(# cat /etc/shells)  
例如#!/bin/bash(解释器)  
# 其中间可以添加一些注释信息，例如脚本的使用方法、脚本的功能、创建日期、作者等相关信息  
然后赋予脚本具有执行权限，# chmod +x scripts.sh  
执行则使用./scripts.sh ##也可以将此脚本的路径添加到PATH变量中，以后直接使用脚本名称直接运行。  
脚本的测试工具bash：  
-n：检查脚本是否有语法错误，有则显示错误信息，否则无信息(没有消息才是最好的消息)  
-x：检查脚本在执行中的详细过程(排错时，经常会用到)  
exit：退出脚本(其数值为0-255)  
如果脚本没有明确定义退出码，那么在执行脚本结束前的退出码为此脚本的退出码。  
# echo $?     ##查看上一个命令执行结果所显示的状态码

SHELL脚本的逻辑关系总结：

逻辑与：符号为&&：
如果其中一个为假，则结果一定为假  
如果第一个条件结果为假，则第二个条件不用再判断，最终结果已显示  
如果第一个条件结果为真，则第二个条件必须判断
范例：
# useradd redhat && echo "redhat" | passwd --stdin redhat 解说：如果useradd redhat执行成功，则继续执行下一条命令，否则终止。

逻辑或||：
如果其中一个条件结果为真，则结果一定为真，不用检查后面的语句  
如果其中一个条件结果为假，则检查下一个条件语句  
范例：
# id redhat || useradd redhat  
解说：如果redhat用户存在，就显示redhat用户相关信息，否则添加此账户。  
逻辑与和逻辑或联合使用范例：  
# id redhat && echo “redhat already existing“ || useradd redhat  
解说：如果redhat用户存在，则显示redhat用户已存在，否则添加此账户。

条件判断语句总结：

单分支if语句双分支if语句     多分支if语句case选择语句  
if 判断条件 ;then    if 判断条件;then     if 判断条件;thencase $1 in
  statement           statement          statement                  string)  
  ......              ........           .........                      statement;;  
fi                  else               elif 判断条件;then             string2)  
                      statement          statement                      statement;;  
                      .....              .........                  ......)  
                   fi                 elif 判断条件;then                 statement;;  
                                                statement           esac  
                                                .........  
else
                                                statement  
                                             fi

范例：

脚本分析：  
主要功能：传递一个不同的参数，来完成用户的创建、添加密码、删除用户。  
详细说明：  
当我们传递--add参数给此脚本时，此脚本为完成指定用户的添加，如果添加的用户存在，则提示用户以存在，否则添加指定用户并创建以用户为自身的密码；
当我们传递--del参数给此脚本时，此脚本会删除我们指定的用户，如果存在则删除此用户，否则提示用户不存在。
当我们传递--help参数给此脚本时，此脚本会给我们现实脚本的使用方法。
当我们传递其它参数时，会提示无法识别的选项。

POSIX的结束状态总结：

0：      ##命令成功所显示的状态  
>0:     ##在重定向或单词展开期间(~、变量、命令、算术展开及单词切割)失败  
1-125   ##命令不成功所显示的状态。  
126     ##命令找到了，但文件无法执行所显示的状态  
127     ##命令找不到，所显示的状态  
>128    ##命令因收到信号而死亡

替换运算符总结(变量的赋值)：

${varname:-word}  
   如果varname存在且非null，则返回其值;否则，返回word;  
   用途：如果变量未定义，则返回默认值  
   范例：如果count未定义，则${count:-0}的值为0  
${varname:=word}  
   如果varname存在且非null，则返回其值;否则，将varname设置为word，并返回其值;  
   用途：如果变量未定义，则设置变量为默认值  
   范烈：如果count未定义，则${count:=0}的值为0  
${varname:+word}  
   如果varname存在且非null，则返回word;否则，返回null；  
   用途：为测试变量的存在  
   范例：如果count已定义，则${count:+1}的值为1  
${varname:?message}  
   如果varname存在且非null，则返回其值;否则显示varname:message,并退出当前命令或脚本;  
   用途：为了捕捉由于变量未定义所导致的错误。  
   范例：如果count未定义，${count:?"undefined!"}则显示count:undefined!

模式匹配运算符总结：

假设path变量的值为：/etc/sysconfig/network-scripts/ifcfg-eth0.text.bak  
${variable#pattern}：  
   如果模式匹配于变量值的开头处，则删除匹配的最短部分，并返回剩下的部分；  
   范例：echo ${path#/*/}的值为etc/sysconfig/network-scripts/ifcfg-eth0.text.bak  
${variable##pattern}  
   如果模式匹配于变量值的开头处，则删除匹配的最长部分，并返回剩下的部分；  
   范例：echo ${path##/*/}的值为ifcfg-eth0.text.bake  
${variable%pattern}  
   如果模式匹配于变量的结尾处，则删除匹配的最短部分，并返回剩下的部分;  
   范例：echo ${path%.*}的值为/etc/sysconfig/network-scripts/ifcfg-eth0.text  
${variable%%pattern}  
   如果模式匹配于变量的结尾处，则删除匹配的最长部分，则返回剩余部分。  
   范例：echo ${path%%.*}的值为/etc/sysconfig/network-scripts/ifcfg-eth0  
${#variable}  
   显示variable变量值的字符长度

Shell脚本常用的循环语句总结：

for循环                       while循环                 until循环  
for 变量 in 列表 ;do    while condition(条件);do      until condition ;do  
   command...              statements                      statements  
done                    done                            done  
 
while循环：只要condition满足条件，while会循环  
until循环：只要condition不满足条件，until会循环

test命令

    test命令可以处理shell脚本中的各类工作，它产生的不是一般输出，而是可使用退出状态，test接受各种不同的参数，可控制它要执行哪一种测试  

    语法：

    test [ expression ]

    test [ [expression] ]

    用途：

    为了测试shell脚本里的条件，通过退出状态返回其结果。

    行为模式：

    test用来测试文件的属性、比较字符串、比较数字

    主要选项与表达式：

    string      string不是 null

    -b file     file是块设备文件(-b)

    -c file     file是字符设备文件(-c)

    -d file     file为目录(-d)

    -e file     file是否存在

    -f file     file是一般文件(-)

    -g file     file有设置它的setgid位

    -h file     file是一个符号链接

    -r file     file是可读的

    -s file     file是socket

    -w file     file是可写的

    -x file     file是可执行的，或file是可被查找的目录

    s1 = s2     s1与s2字符串相同

    s1 != s2    s1与s2字符串不相同

    n1 -eq n2   整数n1与n2相等

    n1 -ne n2   整数n1与n2不相等

    n1 -lt n2   整数n1小于n2

    n1 -gt n2   整数n1大于n2

    n1 -le n2   整数n1小于或等于n2

    n1 -ge n2   整数n1大于或等于n2

    -n string   string是非 null

    -z string   string为 nul l特殊参数变量

    在bash shell中有些特殊变量，它们会记录命令行参数的个数。例如$#

    你可以只数一下命令行中输入了多少个参数，而不同测试每个参数。bash为此提供了一个特殊的变量，就是上面所提到的$#

    $#的说明

        $#特殊变量含有脚本运行时就有的命令行参数的个数。你可以在脚本中任何地方来调用这个特殊变量来调用$#来计算参数的个数

    范例:

        vim Count.sh

        #!/bin/bash

        #Script Name: Count.sh

        # Count Parameters number

        echo There were $# parameters.

        chmod +x Count.sh

        ./Count.sh 1 2 3

        There were 3 parameters.

下面来说下${!#}的作用？

既然$#变量含有参数的总数量，那么${!#}可以调用最后一个参数的变量名称。

范例：

vim Count-1.sh

#!/bin/bash

#Script Name: Count-1.sh

# Print last parameter

params=$#

echo "The last parameter is "$params"

echo "The last parameter is "${!#}"

:wq

chmod +x Count-1.sh

./Count-1.sh  1 2 3

The last parameter is 3

The last parameter is 3 原文出自 http://guodayong.blog.51cto.com/263451/1188606
