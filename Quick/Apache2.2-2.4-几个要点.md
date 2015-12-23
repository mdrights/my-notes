Apache 2.2升级到2.4后的几个要点

[日期：2015-01-17] 	来源：Linux公社  作者：fjxichao 	[字体：大 中 小]

     从Ubuntu 12.04到14.04的升级会带来一些重要的更新，比如说Apache2.2到2.4的更新。Apache的更新虽然带来一些改进，但是当你用apache2.2的配置文件时是不是有可能会引起错误呢。

Apache2.4虚拟主机的访问控制

      Apache2.4的授权比之前更加灵活，仅仅是简单检查下类似在Apache2.2中的一个数 据仓库。过去，很难知道如何授权，以何种顺序授权，但是随着授权容器命令（比如说and）的引入，授权时的配置 问题就能解决，也能知道决定什么时候拥有访问权限的规则。

     配置出错就是大多数更新失败的问题所在，在Apache2.2中，访问控制是基于IP地址， 主机和其他使用命令行排序，准许，拒绝和满足条件的特征，但是在Apache2.4中，这只要在授权检查时使用一个 新的模块就能完成。

      为了更加明白，我们看看几个虚拟主机的实例，在你的/etc/apache2/sites- enabled/default或者/etc/apache2/sites-enabled/YOURWEBSITENAME能够看到：

     旧的Apache2.2的虚拟主机配置：

 Order allow,deny
 Allow from all

     新的的Apache2.4的虚拟主机配置：

 Require all granted

Ubuntu 14.04中Apache 2.2升级到2.4后的几个要点

.htaccess问题

      如果更新后一些设置不能使用或者出现需要重新配置的错误，那么你检查下这些设置 是不是在一个.htaccess文件中。如果.htaccess文件中的设置没有被使用，那是因为2.4里AllowOverride 默认被设置为None，于是.htaccess文件被忽略了。你要么更改要么增加AllowOverride所有的命令到你的 site配置文件中。

     你也能在上面的屏幕截图中看到AllowOverride所有的命令设置。

丢失的配置文件和模块

      根据我的经验，更新的另一个问题是配置文件包含旧的模块或者配置文件在2.4中不被需要或者不被支持，你会看到一个显眼的警告Apache can't include the respective file and all you have to do is go to your configuration file and remove the line that causes problem。之后你可以查询或者安装一个相同的模块。

你需要知道的其他小的改变

      有一些其他的改变尽管通常导致警告，不导致错误，但是需要你注意：

            >MaxClients改名为MaxRequestWorkers，精确的描述出了它是什么。对于异步的MPMs,就像事件，客户的最大数不等于工作的线程数。旧的名字仍旧被支持。
            >命令DefaultType不再使用，若是被赋值使用（不为none）就导致一个警告。在2.4中你需要使用其他配置设置来代替它。
            >EnableSendfile默认是Off。
            >FileETag 默认值是"MTime Size"（没有INode）。
            >KeepAlive 接受 On 或者 Off两个值。之前，除了Off和0之外的值都被当作On处理。
            >命令 AcceptMutex, LockFile, RewriteLock, SSLMutex, SSLStaplingMutex, and WatchdogMutexPath 已经被一个命令 Mutex 所代替。你需要估计一下在2.2的配置中这些被去除的命令的使用去决定他们是不是仅仅被删除或者需要被 Mutex 所代替。