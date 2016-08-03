
杨深锐的博客

一些思绪
Follow in NewsfeedFollowing
文章分类

    ==有料站点推荐==

东先生的ZeroBlog

编程随想的博客镜像

INXIAN 的官方镜像

浮生網志

微隐世界

蔓草札记

ZeroDrive

中文网站导航

The World of Codegass

ZeroID : @sary

Fuck GFW
Latest comments:

    a: 去中心化是进化的必然选择。去中心化是需要锚定一个东西，但这个东西未必是权力。例如黄金是谁背书呢？
    @ 我们谈论去中心化时，哪些领域已经开始？（一）
    a: 去中心化是个太大的概念
    @ 我们谈论去中心化时，哪些领域已经开始？（一）
    g7900ms: 我感觉 去中心化的意义在于成立一个完美的 “临时存放地” ，一个 easy-come-easy-on ...
    @ 我们谈论去中心化时，哪些领域已经开始？（一）
    kldjfkldasjf: 沙发
    @ 我们谈论去中心化时，哪些领域已经开始？（一）
    or: 我从 github 上正常下载 python/.cmd 文件，并顺利安装。我本机部署的有 xx-net
    @ My first post!
    idlesong: 之前看到文章说，其实还有一块，好多商业化的貌似中心化的服务，其实都已经在应用P2P的方式。
    @ 我们谈论去中心化时，哪些领域已经开始？（一）
    sary: 享受它，并让更多的人享受它。
    @ 如何评价zeronet，是否是革命性的创新？其发展前景如何？与传统网站相比有何优缺点？
    sary: tumutanzi 你好，id好熟悉。哈哈
    @ 如何评价zeronet，是否是革命性的创新？其发展前景如何？与传统网站相比有何优缺点？
    sary: 什么意思？
    @ 如何评价zeronet，是否是革命性的创新？其发展前景如何？与传统网站相比有何优缺点？
    tumutanzi: 试验一下，能不能贴链接： ...
    @ 如何评价zeronet，是否是革命性的创新？其发展前景如何？与传统网站相比有何优缺点？
    tumutanzi: 你可能是ZeroNet中文里目前最活跃的博客之一了~
    @ 如何评价zeronet，是否是革命性的创新？其发展前景如何？与传统网站相比有何优缺点？

扫描下面二维码使用手机访问 :
我们谈论去中心化时，哪些领域已经开始？（一）
on Apr 26, 2016 ·
5 comments
3

    无处不在的数字现金与大规模电子网络配合默契。互联网绝对会是第一个电子货币深入渗透的地方。货币是另一类信息，一种小型的控制方式。货币也会随着互联网延伸而扩展。信息流动到哪里，货币肯定也会跟随其后。由于其去中心化、分布式的本性，加密的电子货币肯定能改变经济结构，就像个人电脑颠覆了管理和通讯结构一样。最重要的是，在信息社会中，电子货币所需的私密性/安全性创新对于发展出更高层级的可适应的复杂性至关重要。我还要说：真正的数字现金，或者更准确地说，真正的数字现金所需要的经济机制，将会重新构造我们的经济、通讯以及知识。

以上是节选自凯文凯利（ Kevin Kelly ）的《失控》。该成书于1994年，关于未来的预言让人惊讶。几年间我前后看了几遍，每看一次都有新的认识。例如上面的节选中KK所谈到的电子货币，第一次看这本书时仅仅对“分布式”有一点皮毛的认识，根本不知道什么是“电子货币”，还以为讲的是paypal。再后来知道了有DigiCash、bitgold、e-cash,也许《失控》中所描述的就是DigiCash，但现在再回头一看，分明就是在描述比特币。里面还有很多关于去中心化的描述，十分精彩。

言归正传，当我们在谈论去中心化时，看看世界发生了哪些变化，都有什么已经实现了去中心化？当然这个范围太大，以一个技术人员的角度一点点讲起，一定有不少错误，还请读者指出。
文件共享

第一个是影响最为深远的是BT (BitTorrent),BT 实现了文件共享的去中心化。Napster 作为文件去中心化分享领域的先行者获得极大的成功，虽然被唱片公司联合起诉然后败诉并破产，但这仅仅是一小股逆流，Napster的失败将开源的BitTorrent推向了更大的成功。

第二个BitTorrent Sync，这个 是BT公司推出的新的资源分享、文件同步工具。目前口碑不错。

第三个，IPFS，自称“a new peer-to-peer hypermedia protocol.”，就发展速度看来，去中心化这条路还很漫长，原因是对目前对网关的依赖性太强，就天朝而言，没等ipfs积累够多的种子用户，就被GFW给干扰的七荤八素了。

第四个，ZeroNet, 访问即存储结构，结合BitTorrent的寻址、文件共享、种子分发技术，Bitcoin的加密方式形成了一个WWW替代性方案，目前来看比较适合小容量的网站。这仅仅是0.3x版本的软件速度已经非常快、界面友好，十分有潜力。
货币与金融

首屈一指的就是发布于2009年的比特币，在创始人中本聪(Satoshi Nakamoto)的白皮书中描述很精准“ Bitcoin: A Peer-to-Peer Electronic Cash System ” 。它的特征就是开源、去中心化、允许匿名，还有低手续费、数量有上限等特征。拆开来看比特币所用的技术都不是横空出世，但组合起来让人感觉精妙之处一言难尽，试着举几个例子：（1）区块链技术实现了分布式网络中的一致性的账本；（2）去中心化环境中对记账权的分配（POW算法）解决了分布式网络中的“拜占庭将军问题”，并带有网络自动调节功能；（3）使用椭圆加密算法实现零知识证明，顺带躲开了一堆带后门的算法。

由于比特币的开源特性，基于比特币代码的改进也形成了一些其他的电子货币，被成为“山寨币”，比较有名的有 莱特币（litecoin）、狗狗币（dogecoin）,大大小小有几百种，有的各具特色，有的浑水摸鱼。国内的山寨币有元宝币、招财币等，个人不看好不做展开。

比特币不但是电子货币，也是支付系统。一个借鉴了比特币的思想发展而来的支付网络--Ripple，虽去中心化程度有限，但跟老掉牙的支付清算体系 visa 比还是有不少进步。

另外比特币的条件支付功能也启发了另外一些人，少年天才Vitalik认为比特币的条件支付可以扩展成为智能合约，实现根据事先任意制订的规则来自动转移数字资产的系统，从而创立了以太坊（Ethereum ）； Bytemaster 参考比特币的区块链思想，将POW算法替换为DPOS(股份授权证明机制算法)实现的多态资产与分布式交易系统 bitshares。

另外国内团队也有一些比较有潜力的项目，例如 @达鸿飞 的 小蚁AntShares 立足点是 基于区块链技术的资产数字化系统。

币联网bitnet 团队的vpncoin，将电子货币与vpn技术结合。有偿翻墙自动结算。
如何评价zeronet，是否是革命性的创新？其发展前景如何？与传统网站相比有何优缺点？
on Apr 13, 2016 ·
17 comments
5

    在知乎上水了一篇回答，安利了一下ZeroNet：

    知乎链接：如何评价zeronet，是否是革命性的创新？其发展前景如何？与传统网站相比有何优缺点？

我的观点： ZeroNet是具有革命性的。它使得WWW的去中心化又前进了一步。

WWW使用统一资源定位符（ URL）将分布在世界各地的资源汇聚在一起，同时单个服务器的当机又不影响整个WWW的使用，这是一个伟大的构想，目前来看十分成功。

在1990年，世界上第一台WWW服务器诞生于欧洲原子核研究委员会，服务器上被贴了个标签：不要关掉它，这是一台服务器。

虽然WWW在整体上是分布式的结构，但是在具体的服务上，WWW并没有提供分布式的功能。
随着WWW规模的扩大，某些站点的压力也越来越大，单台服务器就变为了多台服务器。在早期大多数是通过dns轮询方式避免服务器的单点故障。再后来有了反向代理技术，当客户端访问时由代理服务器挑选一台服务器给客户端连接。

另一方面，服务器与客户端的物理距离有远有近，物理远的访问就慢距离近的访问速度就快，例如中国用户访问美国服务器就比较慢。两千零几年的中国更过分，同一个城市的电信网络用户访问联通网络的服务器就很慢！ 这时候google、腾讯等一些大型的服务商，开始研究CDN（Content Delivery Network，即内容分发网络），将一些内容主动推送到离用户较近的服务器，用来提升用户的访问速度。这些也是WWW的使用者在WWW之外做的优化。

反过来看：
(1) 反向代理技术避免了单点故障事实上是采用去中心化的逻辑；
(2) CDN技术提升了用户访问速度也是采用去中心化的逻辑；
(3) 大型互联网提供商的“异地多活”方案也是去中心化的逻辑；

说到这，就不得不提的另外一个具有创新性的东西，就是 BitTorrent ， 在BT网络，每台接入设备既是服务器又是客户端， 在BT的P2P协议中，资源的发布者一旦被其他人下载并且没有关机，其他人就可以从所有具有这个资源的节点下载文件。据说在google内部已经使用Bittorrent协议来跨机房更新内容了。

那么WEB服务的去中心化是不是已经呼之欲出了？
结合bitcoin的签名技术和BitTorrent文件分享技术的访问即存储的网络，就是ZeroNet。ZeroNet并不是孤立于互联网，而是具有吞噬互联网的架势。在ZeroNet的语境中，现在的WWW服务可以称为传统互联网，ZeroNet将是它的超集，仍然可以使用域名服务（不是Namecoin和ZeroNet的ZeroID，是传统的DNS服务），仍然可以使用vps 托管你的网站。但采用ZeroNet技术，你的网站将立刻具有异地多活功能、自带N个备份、自带CDN加速功能。

虽然现在ZeroNet尚未成熟，但它的颠覆能力不可小觑。

ZeroNet刚刚起步，却已经有了竞争者：
IPFS is a new peer-to-peer hypermdia perotocol.

目前从发展速度上和易用性上，ZeroNet更占上风。

顺便说一下：我已经在ZeroNet成功开了个博客，目前应该有80个节点。
ZeroNet用户访问我的博客：
http://127.0.0.1:43110/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ/

非ZeroNet用户访问我的博客：
https://zeroproxy.atomike.ninja/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ/
或
http://proxy.zeroexpose.com/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ/

参考资料：

    世界上第一台Web服务器（3张）
    专访阿里巴巴毕玄:异地多活数据中心项目的来龙去脉

ZeroBlog 如何显示当前连接节点数量
on Apr 11, 2016 ·
5 comments
1

在 ZeroNet 网络中每个网站至少有一个Peer，Peer越多访问速度也就越快。如何在博客中显示站点当前的节点数目?经过翻查代码，简单修改all.js和index.html即可达到目的。
1. 修改/js/all.js

    在/js/all.js中增加获取节点信息的代码

    ZeroBlog.prototype.reloadPeers = function() {
    return this.cmd("siteInfo", {}, (function(_this) {
      return function(site_info) {
        var peers;
        _this.address = site_info.addres;
        _this.site_info = site_info;
        peers = site_info["peers"];
        if (peers === 0) {
          peers = "n/a";
        }
        return $("#peers").removeClass("updating").text(peers);
      };
    })(this));    
    };

    经过查看代码，发现已经执行了 cmd("siteInfo"),但是没有把节点信息获取到页面上，新增的reloadPeers从siteinfo获取peers信息。

    增加触发代码，先查找以下代码：

     ZeroBlog.prototype.onOpenWebsocket = function(e) {
     this.loadData();

    新增：
    this.reloadPeers();
    下面是修改后的代码:

     ZeroBlog.prototype.onOpenWebsocket = function(e) {
     this.reloadPeers();
     this.loadData();

2. 修改/index.html

将以下代码放置到任意地方：
当前已连接 <span id='peers' class='updating'>0</span> 个节点<br>

我把它放到了页脚，如下图：
img/20160411-peers.png
问题又来了：

我在127.0.0.1 看到的节点数量是29个
在 https://zeroproxy.atomike.ninja/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ/ 看到节点数量是75个
在 https://www.zeropro.xyz/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ 看到节点数量是 55个
在 http://198.71.88.47/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ/ 节点数量43个

为什么差异这么大？
搭建基于ZeroNet的公网博客实践
on Apr 09, 2016 ·
20 comments
2

由于外网服务器抽风，连最基础的ssh都不能正常工作。前后花了一整天才配好。诅咒GFW。

    病魔加油

目前 http://127.0.0.1:43110/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ/ 已经映射到 http://198.71.88.47/ 这个IP仅仅是测试，以后几天可能会有调整。

过程记录如下：
步骤

    在vps上安装ZeroNet，并去掉私钥；
    从：https://github.com/HelloZeroNet/ZeroBundle/releases/download/0.1.1/ZeroBundle-linux64-v0.1.1.tar.gz 下载 linux64版本
    然后
    tar xvpfz ZeroBundle-linux64-v0.1.1.tar.gz
    cd ZeroBundle
    nohup sh ./ZeroNet.sh &
    使用curl http://127.0.0.1:43110 能看到信息就OK。

    设置ZeroNet目录只读；
    设置只读是为了防止www服务当成代理工具。目前来看用目录权限来设置会有一些问题。只能在启动服务之后设置目录权限，重启就会失败。经检查，服务启动或重启时有一个动作是“删除cert-rsa.pem” 然后重新生成。这时候由于目录没有权限而失败。准备给开发组提个issue。

    设置网站目录可写，例如本博客的目录为
    ZeroBundle\ZeroNet\data\19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ

    配置 nginx 反向代理指向 127.0.0.1:43110;
    由于ZeroNet框架使用websocket通讯，也需要支持websocket的反向代理。

         location / {
             proxy_pass http://127.0.0.1:43110/;
             proxy_set_header X-Real-IP $remote_addr;
             proxy_set_header Host $host;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_http_version 1.1;
             proxy_set_header Upgrade $http_upgrade;
             proxy_set_header Connection "upgrade";
     }

    配置 nginx 支持https;
    暂未配置

ZeroNet上有哪些有意思的资源？
on Apr 09, 2016 ·
2 comments
2
一些有意思的ZeroNet站点

    GIF Time，一些GIF图片
    http://localhost:43110/1Gif7PqWTzVWDQ42Mo7np3zXmGAo3DXc7h/
    标题比图还亮

    PLAY，据说是ZN版的海盗湾
    http://127.0.0.1:43110/1PLAYgDQboKojowD3kwdb3CtWmWaokXvfp/

    巴拿马文件，夹了一些64相关的东西
    http://localhost:43110/PanamaPapers.bit

    GFW Talk，人气比较旺的中文论坛
    http://127.0.0.1:43110/1Nse6WcodQ5Mj6ZwvZvuyCVvQESwuxbCUy/

    东先生的ZeroBlog， 活跃用户
    http://127.0.0.1:43110/1A2zwx1maY1fZv18vaEFFaCuiS88xqWvzV/

    编程随想的博客的ZN镜像 ，编程随想Blogspot的镜像
    http://127.0.0.1:43110/15gfg6DUVkp7ApLSMQvC2ig5qy8j91jXeW/

    GXQ，感兴趣，另一个中文讨论组
    http://127.0.0.1:43110/1NzWeweqJ32aRVdM5UzFnYCszuvG5xV3vS/

    ZN搜索引擎，不过这个不是ZeroNet上的
    http://zeroexpose.com/

WWW上的一些讨论

    52pojie：Zeronet-一分钟搭建你的p2p全球网站
    http://www.52pojie.cn/forum.php?mod=viewthread&tid=483511

    月光博客: 使用ZeroNet搭建P2P全球网站
    http://www.williamlong.info/archives/4574.html

    土木坛子：简评ZeroNet分布式P2P网络
    https://tumutanzi.com/archives/15178

WWW通往ZN结界的桥梁

    zeropro.xyz
    https://www.zeropro.xyz/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ

    zeroproxy.atomike.ninja
    https://zeroproxy.atomike.ninja/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ/

    zeroexpose
    http://proxy.zeroexpose.com/19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ/
    2016-4-11，新增，http://zeroexpose.com/ 也提供了ZeroNet的搜索功能

一个基于ZeroNet搭建网站的思路
on Apr 08, 2016 ·
6 comments
1
前置任务

准备一台vps作为前端服务器，提供给非ZeroNet用户访问。
准备nginx
步骤

    在vps上安装ZeroNet，并去掉私钥；
    设置ZeroNet目录只读；
    设置网站目录可写，例如本博客的目录为
    ZeroBundle\ZeroNet\data\19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ
    配置 nginx 反向代理指向 127.0.0.1:43110;
    配置 nginx 支持https;

效果：

访问 www.foo.com 即可访问 19fZz85PJXLAuwpGWe2fLEnU6Z1heprFFJ
本地使用ZeroNet可更新；
题外话

ZeroNet官网完全可以使用ZeroNet搭建，完成Bootstrap；
还有t66y，打成docker镜像就可以一键转移了 :P
My first post!
on Apr 07, 2016 ·
15 comments

ZeroNet是修正后的WWW模型，十分看好。

目前是0.1.1 版本。
http://zeronet.io/ 官网上链接指向了aws，被GFW干扰。通过自己的外网vps下载然后启动
python -m SimpleHTTPServer 作为中转。

安装启动一气呵成，不要太顺利！
当前已连接 33 个节点
Powered by ZeroNet [ open, free, and uncensored ]
Posts
Comments
