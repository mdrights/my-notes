
轻松使用“Explain Shell”脚本来理解 Shell 命令

2015-8-9 09:30    评论: 10 收藏: 4    

参考原文：http://www.tecmint.com/explain-shell-commands-in-the-linux-shell/ 作者： Avishek Kumar
编译文章：LCTT  https://linux.cn/article-5979-1.html 译者： dingdongnigetou
文章地址：https://linux.cn/article-5979-1.html

我们在Linux上工作时，每个人都会遇到需要查找shell命令的帮助信息的时候。 尽管内置的帮助像man pages、whatis命令有所助益， 但man pages的输出非常冗长， 除非是个有linux经验的人，不然从大量的man pages中获取帮助信息是非常困难的，而whatis命令的输出很少超过一行， 这对初学者来说是不够的。

Explain Shell Commands in Linux Shell

在Linux Shell中解释Shell命令

有一些第三方应用程序， 像我们在Linux 用户的命令行速查表提及过的'cheat'命令。cheat是个优秀的应用程序，即使计算机没有联网也能提供shell命令的帮助， 但是它仅限于预先定义好的命令。

Jackson写了一小段代码，它能非常有效地在bash shell里面解释shell命令，可能最美之处就是你不需要安装第三方包了。他把包含这段代码的的文件命名为“explain.sh”。
explain.sh工具的特性

    易嵌入代码。
    不需要安装第三方工具。
    在解释过程中输出恰到好处的信息。
    需要网络连接才能工作。
    纯命令行工具。
    可以解释bash shell里面的大部分shell命令。
    无需使用root账户。

先决条件

唯一的条件就是'curl'包了。 在如今大多数Linux发行版里面已经预安装了curl包， 如果没有你可以按照下面的命令来安装。

# apt-get install curl  [On Debian systems]
# yum install curl      [On CentOS systems]

在Linux上安装explain.sh工具

我们要将下面这段代码插入'~/.bashrc'文件（LCTT译注: 若没有该文件可以自己新建一个）中。我们要为每个用户以及对应的'.bashrc'文件插入这段代码，但是建议你不要加在root用户下。

我们注意到.bashrc文件的第一行代码以（#）开始， 这个是可选的并且只是为了区分余下的代码。

#explain.sh 标记代码的开始， 我们将代码插入.bashrc文件的底部。（备注：原代码有误，处理 https 时需要指定加密套件，据微信网友“高小树”同学的改进，原来的-Gs应该修改为-G --ciphers ecdhe_ecdsa_aes_128_sha。谢谢“高小树”同学。）

# explain.sh begins
explain () {
  if [ "$#" -eq 0 ]; then
    while read  -p "Command: " cmd; do
      curl -G --ciphers ecdhe_ecdsa_aes_128_sha "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
    echo "Bye!"
  elif [ "$#" -eq 1 ]; then
    curl -G --ciphers ecdhe_ecdsa_aes_128_sha "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
    echo "Usage"
    echo "explain                  interactive mode."
    echo "explain 'cmd -o | ...'   one quoted command to explain it."
  fi
}

explain.sh工具的使用

在插入代码并保存之后，你必须退出当前的会话然后重新登录来使改变生效（LCTT译注：你也可以直接使用命令source ~/.bashrc 来让改变生效）。每件事情都是交由‘curl’命令处理， 它负责将需要解释的命令以及命令选项传送给mankier服务，然后将必要的信息打印到Linux命令行。不必说的就是使用这个工具你总是需要连接网络。

让我们用explain.sh脚本测试几个笔者不懂的命令例子。

1.我忘了‘du -h’是干嘛用的， 我只需要这样做:

$ explain 'du -h'

Get Help on du Command

获得du命令的帮助

2.如果你忘了'tar -zxvf'的作用，你可以简单地如此做:

$ explain 'tar -zxvf'

Tar Command Help

Tar命令帮助

3.我的一个朋友经常对'whatis'以及'whereis'命令的使用感到困惑，所以我建议他：

在终端简单的地敲下explain命令进入交互模式。

$ explain

然后一个接着一个地输入命令，就能在一个窗口看到他们各自的作用：

Command: whatis
Command: whereis

Whatis Whereis Commands Help

Whatis/Whereis命令的帮助

你只需要使用“Ctrl+c”就能退出交互模式。

4. 你可以通过管道来请求解释更多的命令。

$ explain 'ls -l | grep -i Desktop'

Get Help on Multiple Commands

获取多条命令的帮助

同样地，你可以请求你的shell来解释任何shell命令。 前提是你需要一个可用的网络。输出的信息是基于需要解释的命令，从服务器中生成的，因此输出的结果是不可定制的。

对于我来说这个工具真的很有用，并且它已经荣幸地添加在我的.bashrc文件中。你对这个项目有什么想法？它对你有用么？它的解释令你满意吗？请让我知道吧！

请在下面评论为我们提供宝贵意见，喜欢并分享我们以及帮助我们得到传播。

via: http://www.tecmint.com/explain-shell-commands-in-the-linux-shell/

作者：Avishek Kumar 译者：dingdongnigetou 校对：wxy

本文由 LCTT 原创翻译，Linux中国 荣誉推出
