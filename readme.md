## 介绍

该项目旨在开发一个轻量级的网络自动认证脚本，适用于在路由器上运行。该脚本可用于实现路由器的网络认证功能，自动完成与认证服务器的交互，实现无需人工干预的网络认证过程。

## 使用说明

1. 将`your_account_number_here`替换为你的统一身份认证账号，`your_password_number_here`替换为统一身份认证密码。

2. 将脚本文件部署到路由器上的合适位置，并赋予执行权限。

3. ```
   bash websign20230614.sh
   ```

   可以在openwrt的计划任务中添加

```
* * * * * /bin/bash websign20230614.sh
```

4.如遇websign20230614.sh: line 1: syntax error near unexpected token `$'{\r''

请执行`sed -i 's/\r$//' websign20230614.sh`

# 后记

这段代码原计划是在Bourne Shell中实现的，以实现更好的兼容性，所以rc4函数的实现方式非常奇怪，但是折腾了一下午还是改成了bash，后续有空会再试试看Bourne Shell的实现

