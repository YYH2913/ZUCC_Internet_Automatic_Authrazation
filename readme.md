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

​		学校的网其实是每天的三点半断的，所以理论上不需要每分钟执行一次

4.如遇websign20230614.sh: line 1: syntax error near unexpected token `$'{\r''

请执行`sed -i 's/\r$//' websign20230614.sh`

5.如遇 ./websign20230616.sh: local: line 2: not in a function

也请执行`sed -i 's/\r$//' websign20230616.sh`

# 后记


查了一下openwrt默认集成的是Almquist shell，因此0616版实现了Almquist shell的直接运行，现在可以将计划任务改成

```
* * * * * websign20230616.sh
```

20231122update
实现了BusyBox v1.24.2 built-in shell (ash)下脚本的运行支持，后续随缘更新啦（虽然本来也随缘╮(￣⊿￣)╭
