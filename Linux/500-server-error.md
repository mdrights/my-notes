一般的500错误解决方法：

    web根目录（或是php文件）权限错误
    解决：将根目录的权限由错误的777改成755 解决：将php文件的属性改成 644 或是755试试。
    .htaccess文件错误
    解决：修改.htaccess文件的内容，在本机制作一个空的.htaccess文件，上传覆盖。

一般的500错误大多数是权限的问题，或是url rewrite造成的。

在这个case，直接就排除了上面的原因。继续~~~

    猜测是PHP安装时出错的原因，重新装了PHP，也不行。
    httpd.conf 与 php.ini的配置已经重复的检查过几遍了。也不行。再继续~

继续查找log_error文件的记录，发现错误都是：Premature end of script headers
Premature end of script headers错误

又是一轮百度，google之后，发现这个错误是CGI文件才会有的错误。网上的资料都是运行CGI文件引起的错误。也是修改权限（755 或是777）之后就能解决的。但是php文件也有这种提示就奇怪了。

终于，在对照了二份httpd.conf的配置之后，发现httpd.conf里多了一句：

    AddHandler x-httpd-php5 .php

    把它注释掉

    #AddHandler x-httpd-php5 .php

重启apache， service httpd restart

终于一切正常。猜想的原因可能是把php文件当作CGI文件引起的错误。具体是不是就不知了~


