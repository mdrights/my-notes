
宇宙第一 shell —— fish 入门

2015-12-8 11:03    评论: 1    

参考原文：http://www.jianshu.com/p/7ffd9d1af788/comments/964067 作者： MountainKing

    二逼青年用 bash，普通青年用 zsh，文艺青年用 fish。

安装以及配置

Linux 和 OS X 基本都可以通过源来安装，实在不行就下载源码编译，不难的。

安装好第一步是修改 OS 默认 shell：

chsh -s /usr/bin/fish

然后就可以直接使用了，就是这么简单。你不需要面对 zsh 浩如烟海的配置文件，也不需要去 github clone 一个 “Oh My Zsh”。

当然如果你实在想配置，输入 fish_config 命令会启动 web 管理界面。

什么？逼格太低，非要手动配置。OK， ~/.config/fish/config.fish这就是 fish 的配置文件，类似于 bash 的.bashrc。

我喜欢配置三件东西：

    问候语（配置config.fish）：

    set fish_greeting 'Talk is cheap. Show me the code.'

    命令行提示（在web界面配置，完成后会生成~/.config/fish/functions/fish_prompt.fish）：

    设置接受建议（第三条优势）的快捷键：

    修改fish_prompt.fish，增加一条语句：bind \ej accept-autosuggestion。同时按下alt和j将接受建议。

优势
语法高亮

不存在的命令会显示为红色。

通配符

集成find命令，递归搜索神器。

 
智能建议

当按下几个字母后，fish会有智能建议，按下向右箭头将接受建议。

 
Tab补全

如果补全项超过1个，会列出全部以供选择。

 
变量

fish是通过set来代替“=”对变量赋值的。

将某目录加入到PATH中也是用set（配置config.sh）：

set PATH $PATH /home/mountain/shell

 
Exports

fish没有export命令，需要用set -x来代替。如果需要擦除变量，就执行set -e。

 
列表

有些变量有多个值，例如$PATH，fish会把所有值组装成一个列表，可以迭代或者通过下标访问。

 
命令替换

用法很简单，把命令放在括号里即可。

 
语法糖

fish 的常用关键字（if、switch、function 等）比 bash 高端、实用很多，但是考虑到公司的生产环境根本不可能安装 fish，导致脚本无法移植，所以对于这部分只能忍痛放弃。
总结

这篇文章虽然字数不多，但是凝结了我不少心血，基本把官方文档全翻译了一遍，然后提取了简单实用的功能分享给大家，还有很多牛逼的功能限于我能力有限就不在这班门弄斧了。
