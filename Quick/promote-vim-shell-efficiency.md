
提高 Vim 和 Shell 效率的 9 个建议

2015-7-5 11:05    评论: 1 收藏: 5    

参考原文：https://danielmiessler.com/blog/enhancements-to-shell-and-vim-productivity/
编译文章：http://blog.jobbole.com/86809/ 译者： zer0Black
文章地址：https://linux.cn/article-5755-1.html

1. 重映射 CAPSLOCK 键

你上一次使用 CAPSLOCK 键是什么时候？很久没有了对不对？噢，我也是，它已经被遗忘了，它浪费了键盘上一个黄金位置。让我们把它重映射成 Control 键来发挥它的作用吧！这里告诉了你在不同的操作系统上的具体操作。

现在你可以保持标准键位手势，随意的敲击到 a键左边的 crtl 了。
2. 使用 ctrl-r 来搜索和自动重做历史命令

许多人都知道可以使用箭头键来都调用上一个历史命令，但相对的，很少有人知道可以使用 ctrl-r来迅速完成历史命令的调用。

一旦找到相应的命令，可以通过回车来执行，或者在执行前对命令进行修改，这很容易会养成习惯，特别是在你把 CAPSLOCK 键重映射以后。
3. 使用 OS X 系统的 iTerm

iTerm 不是必须要用的高效工具，但绝对能提升效率。它有如下特性：

    屏幕分割
    选中即复制
    剪切历史
    全屏切换
    系统热键
    Exposé 所有 Tab
    保存当前快照

我还不知道有哪个人换到 iTerm 以后还愿意换回来的。上吧。
4. 把 Zsh 作为 Shell

大部分人会像我以前一样是用 Bash 的人，看了 Zsh 的优点之后，绝大多数人就会对它赞不绝口并且再也不愿意用 Bash 了。它的特性如下：

    目录补全：ve/pl/re --> vendor/plugins/redmine
    环境变量展开：$PATH --> /your/full/path
    智能修正：/pbulic/html 变 /public/html
    拼写修正
    命令历史共享
    行编辑高亮模式
    完美兼容 Bash 大部分配置
    运行/bin/sh的时候可以媲美Bash
    支持vim模式
    OhMyZsh支持

最后一条是决定性的，ohmyzsh包含大量插件（包括 rails、git、OS X、brew 等等），有超过80个终端主题和自动更新。ohmyzsh通过这些来让 shell 用起来很爽。更详细请查看这里。
5. 重映射 vim 的 ESCAPE 键

vim 有多个模式并不是什么大问题，但在模式间切换的时候会感觉很糟。ESC 键有点远，这太麻烦了。当我面对新的 vim 环境时，所做的第一件事就是添加如下映射

inoremap jj <ESC>

6. 重映射 Vim 的 Leader 键

如果你不熟悉 leader 键，也不知道它能为你做什么，那你就从这开始了解吧。它本质上是作为你快捷键的激活键，你可以自定义用哪个键作为你的 leader 键。所以，你可以：

nnoremap j VipJ

这可以让你按下 leader 键结合大写 ‘j’ 后可视化的选择整段并加入行。

我个人用 ‘,’ 键作为我的leader键，这样我可以用 ‘,’ 激活我所有的快捷键，然后通过 ‘jj’ 退出插入模式。你可以在 .vimrc中像这样映射：

let mapleader = ","

7. 在 Shell 中使用 vi 模式

无论是 zsh 还是 bash 你都会想尽可能的使用同样的肌肉记忆，如果你是 vim 用户，这意味着你应该把你的 shell 从 Emacs模式（默认）切换到 vi 模式

这意味着你可以用 vim 的方式编辑你的 shell 命令行：

    b 返回上一个单词
    dd 删除整行
    0, $移动到行末
    …等等。

你可以通过添加下面这行代码到 .zshrc 或 .bashrc 文件来实现这一切：

bindkey -v

你也可以像 vim 一样映射你的 escape 键：

bindkey -M viins ‘jj’ vi-cmd-mode

另一个好处是可以通过j、k来自然的浏览历史记录。还可以在你的.zshrc文件中通过下面的代码添加ctrl-r的功能：

bindkey ‘^R’ history-incremental-search-backward

8. 把tmux加入工作流程

tmux是一个终端复用器，它允许你连接和管理多个服务器端会话。在tmux中可以启动并连接对话，还可以断开，然后在不同的时间地点再次连接。

你也许熟悉类似的解决方案，GNU Screen，但比起 screen，tmux 有如下优势：

    screen 是一个又大又重的项目，并且它的编码中有许多问题
    tmux 是一个轻便的项目，有现代的、高效的代码库
    tmux 是一个完整的客户端服务器项目，而 screen 是屏幕仿真软件
    tmux 支持 vim 和 emacs 的键盘布局
    tmux 支持运行时自动重命名窗口
    tmux 能很方便的通过 shell 实现脚本化
    tmux 自带垂直分屏功能，而 screen 里屏幕被固定死了

如果你用不上终端复用功能，也可以是尝试一下 tmux，你会获益的。[ 更新: 这有 tumx 的最全启蒙书。]
9. 同步工作环境

好了，在你的 MBP 能体验到酷炫的 shell 和 vim 了，但一旦你都 SSH 到你的 Linux 上，就会感觉完全不同，这太令人恼火了。还好，可以通过同步来处理这个问题。

    在 git 上为你的配置文件创建一个仓库，例如：Bash、Zsh、Vim 等等。记得保持更新。
    在你所用的每个系统上都克隆一份（配置文件）到对应系统的目录下。
    有评论说也可以用 Dropbox 来同步，似乎很棒，但我不确定在 Headless（Headless指没有显示器、键盘、鼠标等设备）的 Linux 服务器上工作效果如何。

参考原文：https://danielmiessler.com/blog/enhancements-to-shell-and-vim-productivity/
编译文章：http://blog.jobbole.com/86809/ 译者： zer0Black

本文为转载，如需再次转载，请查看源站 “blog.jobbole.com” 的要求。如果我们的工作有侵犯到您的权益，请及时联系我们。
文章仅代表作者的知识和看法，如有不同观点，请楼下排队吐槽 :D
上一篇：Docker 在 PHP 项目开发环境中的应用
下一篇：如何清洗 Git Repo 代码仓库
发表评论


最新评论
我也要发表评论

来自 - 广东 的 Chrome/Windows 用户 2015-7-10 15:16
    试一下
    赞 3 回复 

热点评论

来自 - 广东 的 Chrome/Windows 用户 2015-7-10 15:16
    试一下
    赞 3 

本文导航

    -1. 重映射 CAPSLOCK 键
    -2. 使用 ctrl-r 来搜索和自动重做历史命令
    -3. 使用 OS X 系统的 iTerm
    -4. 把 Zsh 作为 Shell
    -5. 重映射 vim 的 ESCAPE 键
    -6. 重映射 Vim 的 Leader 键
    -7. 在 Shell 中使用 vi 模式
    -8. 把tmux加入工作流程
    -9. 同步工作环境

相关阅读

    Shell
    vim

    2015-7-8
    Linux 下如何处理包含空格和特殊字符的文件名
    2015-7-20
    从 Vim 到 Emacs 到 Evil
    2015-7-24
    如何管理 Vim 插件
    2015-8-9
    轻松使用“Explain Shell”脚本来理解 Shell 命令
    2015-9-9
    FISH：Linux 下的一个智能易用的 Shell
    2015-9-29
    Vim 自动补全神器：YouCompleteMe

Linux.CN © 2003-2015 Linux中国 | Powered by DX | 图片存储于七牛云存储

京ICP备05083684号-1 京公网安备110105001595

服务条款 | 除特别申明外，本站原创内容版权遵循 CC-BY-NC-SA 协议规定

