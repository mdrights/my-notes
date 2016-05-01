
痛骂程序员

已建站者不在攻击范围之内
测试终于能留言，逼都装碎了
Follow in NewsfeedFollowing
按时间索引
按标签索引

    Source code

Latest comments:

    liutuantuan: 分析太好了 要是做个桌面小程序 ...
    @ ZeroNet/ZeroBlog功能解析
    am630: ...
    @ ZeroNet/ZeroBlog功能解析
    am630: 欢迎补充资源翻译资源 ...
    @ ZeroNet/ZeroBlog功能解析

通过ZeroBlog快速建站
13 hours ago
1
标签: 程序员

本文面向的是有一定编程语言基础，希望将手中已有的大量资源快速转换为ZeroBlog的程序员。

需要javascript、json、nodejs知识。如果只用过javascript也没关系，后面两个是辅助，可以在5分钟之内学会。

好了5分钟已到，你已经懂了json和nodejs，可以往下看了

ZeroBlog的结构很好理解，所有的Blog都存放在data/data.json文件中，默认克隆后的空Blog中的data.json如下

{
        "title": "MyZeroBlog",
        "description": "My ZeroBlog.",
        "links": "- [Source code](https://github.com/HelloZeroNet)",
        "next_post_id": 2,
        "demo": false,
        "modified": 1432515193,
        "post": [
                {
                        "post_id": 1,
                        "title": "Congratulations!",
                        "date_published": 1433033779.604,
                        "body": "Your zeronet blog has been successfully created!"
                }
        ]
}

你要做的就是写一个js脚本，把data.post数组填充成你想要的数据。

nodejs库 jsonfile可以用来读写json文件,npm install安装后可在你的js中引用。

var jsonfile = require("jsonfile");
dataJson = jsonfile.readFileSync("data.json");

var newPost = {
     title: "my js post",
     post_id: dataJson.next_post_id,
     date_published: new Date().getTime()/1000,
     body:'your markdown'
};

dataJson.post.push(newPost);
dateJson.next_post_id++;

jsonfile.writeFileSync("new_data.json",dataJson);

以上步骤就是nodejs读取data.json，更新后写入new_data.json的所有步骤，即使不是程序员也应该一眼就能理解这段代码的逻辑。接下来只需要检查下new_data.json内容是否正确，然后覆盖即可。由于ZeroNet的工作模式，前台页面不会马上刷新，可中断ZeroNet后在终端手动执行dbRebuild后再重开，即可看到你手动更新的结果。

接下来你只需要寻找到合适的咨询来源，无论是你保存的小说还是别人已有的日志，只要把他们填入post，你的ZeroBlog马上就拥有了海量的内容。

如果你使用的ZeroBlog模板支持tag分类，那么可以通过控制data.tag数组来为Blog添加tag。

dataJson.tag.push({
value:'mytag',
post_id:3
});

dataJson.tag.push({
value:'tag2',
post_id:3
});

以上代码将为post_id为3的日志添加mytag和tag2标签。需要注意的是同一个blog不可有重复的标签，否则在dbRebuild时不会成功。
爬虫资源和RSS资源

在之前的基础之上，你可以进一步编写网络爬虫，实时从网上抓取最新最实时的网站信息作为数据来源。解析网站提供的RSS订阅，是比较简单，最容易上手的方式

RSS解析库可使用nodejs库feedparser，你要做的就是把这个API介绍的例子里面的RSS地址换成你自己的地址，把

  while (item = stream.read()) {    
      console.log(item);  
}

改成

  dataJson.post.push({
    title:item.title,
    date_published:new Date(item.pubdate).getTime()/1000,
    body:item.description,
    post_id:xxx
});

即可。这种方式适合于RSS订阅中包含了完整文章的类型，比如INXIAN。对于RSS订阅中没有完整包含全部文章的情况，可通过rss的link属性获取完整页面的链接，然后用jsdom和jQuery来萃取你所需的网页元素。jsdom页面包含了实例代码，你完全可以照抄后用在自己的转换脚本中。jQuery是通过CSS selector来快速操作HTML Dom的一个js库，因此用它萃取页面元素需要HTML Dom和CSS知识。对此有基础的程序员应该在看到jQuery实例之后20s内理解jQuery的含义。在此仅提供几个操作提示。

request库新版需要nodejs4.x

chrome可使用jQuery-injector来快速插入jQuery并在console中测试你的jQuery结果

node-inspector可以使用chrome的debug界面调试你的nodejs脚本

对于被墙的地址可使用http_proxy环境变量令nodejs通过代理访问，但此方法可能令node-inspector调试中断，可预先下载要访问的网络资源，然后通过nodejs的http-server架设本地访问，方便调试。

以上内容对于一个程序员来说，已经是手把手的教程了，任何一个有自尊和自觉的程序员应该动动他们的脑子去把自己所缺失的那部分知识去Google补上。不要TMD来这问json是什么，jQuery怎么用。我这样一个牛逼的程序员的时间很宝贵，没有时间和义务去教授同行这些他们完全可以自学的内容。
5 Comments:
Please sign in ━ new comment
Sign in as...
Submit comment
am630 ━ 4 hours ago
Reply

    p2p: 干货！
    嗯，干制鲍鱼

    我这样一个牛逼的程序员的时间很宝贵，没有时间和义务去教授同行这些他们完全可以自学的内容。

这句话总算有点逼格了，虽然我只是新手，但我也是知道如何自学东西的。我把你这句话记录下来，并合理使用。
fucksociety ━ 4 hours ago
Reply

赞同，一群傻逼，无可救药~
p2p ━ 5 hours ago
Reply

干货！

    没有时间和义务去教授同行这些他们完全可以自学的内容。

赞同！
am630 ━ 8 hours ago
Reply

本章介绍的是：将因特网的资源复制到zeronet中的方法
具体的编程语言，请自学。
nsmzjk ━ 13 hours ago
Reply

求详细教程
Posts
Comments

