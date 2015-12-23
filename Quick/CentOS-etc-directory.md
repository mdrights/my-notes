
CentOS下/etc 目录详解
时间:2015-12-08 10:54来源:手册网 作者:手册网 举报 点击:次

/etc目录
　　包含很多文件.许多网络配置文件也在/etc 中. 

/etc/rc   or/etc/rc.d   or/etc/rc*.d  
　　启动、或改变运行级时运行的scripts或scripts的目录. 

/etc/passwd  
　　用户数据库，其中的域给出了用户名、真实姓名、家目录、加密的口令和用户的其他信息. 

/etc/fdprm  
　　软盘参数表.说明不同的软盘格式.用setfdprm 设置.

/etc/fstab  
　　启动时mount -a命令(在/etc/rc 或等效的启动文件中)自动mount的文件系统列表.Linux下，也包括用swapon -a启用的swap区的信息.

/etc/group  
　　类似/etc/passwd ，但说明的不是用户而是组. 

/etc/inittab  
　　init 的配置文件. 

/etc/issue  
　　getty在登录提示符前的输出信息.通常包括系统的一段短说明或欢迎信息.内容由系统管理员确定. 

/etc/magic  
　　file 的配置文件.包含不同文件格式的说明，file 基于它猜测文件类型.


/etc/motd  
　　Message Of TheDay，成功登录后自动输出.内容由系统管理员确定.经常用于通告信息，如计划关机时间的警告. 

/etc/mtab  
　　当前安装的文件系统列表.由scripts初始化，并由mount 命令自动更新.需要一个当前安装的文件系统的列表时使用，例如df命令. 

/etc/shadow  
　　在安装了影子口令软件的系统上的影子口令文件.影子口令文件将/etc/passwd 文件中的加密口令移动到/etc/shadow中，而后者只对root可读.这使破译口令更困难. 

/etc/login.defs  
　　login 命令的配置文件. 

/etc/printcap  
　　类似/etc/termcap ，但针对打印机.语法不同. 

/etc/profile , /etc/csh.login ,/etc/csh.cshrc  
　　登录或启动时Bourne或Cshells执行的文件.这允许系统管理员为所有用户建立全局缺省环境. 

/etc/securetty  
　　确认安全终端，即哪个终端允许root登录.一般只列出虚拟控制台，这样就不可能(至少很困难)通过modem或网络闯入系统并得到超级用户特权. 

/etc/shells  
　　列出可信任的shell.chsh 命令允许用户在本文件指定范围内改变登录shell.提供一台机器FTP服务的服务进程ftpd检查用户shell是否列在 /etc/shells 文件中，如果不是将不允许该用户登录. 

/etc/termcap 

 
　　终端性能数据库.说明不同的终端用什么"转义序列"控制.写程序时不直接输出转义序列(这样只能工作于特定品牌的终端)，而是从/etc/termcap中查找要做的工作的正确序列.这样，多数的程序可以在多数终端上运行