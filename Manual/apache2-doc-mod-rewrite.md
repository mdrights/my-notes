

Modules | Directives | FAQ | Glossary | Sitemap

Apache HTTP Server Version 2.2
<-
Apache > HTTP Server > Documentation > Version 2.2
Apache mod_rewrite

Available Languages:  en  |  fr  |  tr  |  zh-cn 

mod_rewrite provides a way to modify incoming URL requests, dynamically, based on regular expression rules. This allows you to map arbitrary URLs onto your internal URL structure in any way you like.

It supports an unlimited number of rules and an unlimited number of attached rule conditions for each rule to provide a really flexible and powerful URL manipulation mechanism. The URL manipulations can depend on various tests: server variables, environment variables, HTTP headers, time stamps, external database lookups, and various other external programs or handlers, can be used to achieve granular URL matching.

Rewrite rules can operate on the full URLs, including the path-info and query string portions, and may be used in per-server context (httpd.conf), per-virtualhost context (<VirtualHost> blocks), or per-directory context (.htaccess files and <Directory> blocks). The rewritten result can lead to further rules, internal sub-processing, external request redirection, or proxy passthrough, depending on what flags you attach to the rules.

Since mod_rewrite is so powerful, it can indeed be rather complex. This document supplements the reference documentation, and attempts to allay some of that complexity, and provide highly annotated examples of common scenarios that you may handle with mod_rewrite. But we also attempt to show you when you should not use mod_rewrite, and use other standard Apache features instead, thus avoiding this unnecessary complexity.

    mod_rewrite reference documentation
    Introduction to regular expressions and mod_rewrite
    Using mod_rewrite for redirection and remapping of URLs
    Using mod_rewrite to control access
    Dynamic virtual hosts with mod_rewrite
    Dynamic proxying with mod_rewrite
    Using RewriteMap
    Advanced techniques and tricks
    When NOT to use mod_rewrite
    RewriteRule Flags
    Technical details

See also

    mod_rewrite reference documentation
    Mapping URLs to the Filesystem
    mod_rewrite wiki
    Glossary

Available Languages:  en  |  fr  |  tr  |  zh-cn 

Copyright 2015 The Apache Software Foundation.
Licensed under the Apache License, Version 2.0.

Modules | Directives | FAQ | Glossary | Sitemap

