# Webhook Bridge

桥接不同应用的webhook

有时候webhook双方服务器不认识对方格式，就需要一个中间服务器做一些处理。

例如目前飞书下架了gitlab助手（怨念），就可以使用本程序做转发。gitlab触发push事件时，先把消息发送到本程序，本程序解析并转换为飞书的格式后，再发送给飞书机器人。

目前使用webhookd+python脚本完成，~~讲究一个快糙猛能用就行~~，自用，有需求再扩充。

## 安装 & 运行

可运行于Linux系统，系统需要安装Python3.6+，并下载编译好的[webhookd](https://github.com/ncarlier/webhookd/releases)到仓库根目录。

然后执行`./webhookd -scripts scripts -static-dir www -static-path /www -listen-addr :8080`运行（或使用`make run`命令）。

提示权限问题的话需要给脚本增加执行权限 `chmod +x scripts/api/*`

程序自带一个简易的web界面，可打开 http://SERVER_IP:8080/www/ 查看。

## gitlab发送消息到飞书(Lark)

使用：在飞书群里添加自定义机器人，把机器人的webhook地址粘贴到简易web页面中，再把生成的地址粘贴到gitlab中即可。

另外，因为gitlab的branch filter不好用，这个脚本还支持带逗号分隔的分支过滤。

例如：

飞书机器人的webhook地址为：https://open.feishu.cn/xxxx-xxxx-xxxx-xxxx

启用此服务后，在gitlab中填入：http://SERVER_IP:8080/api/gitlab-feishu.py?hook_url=https://open.feishu.cn/xxxx-xxxx-xxxx-xxxx&branch_filter=master,release/*

其中`branch_filter=master,release/*`为分支过滤条件，此参数可以不填

## 禅道消息发送到飞书(Lark)

老版本禅道webhook不支持飞书，选择默认，地址类似 http://SERVER_IP:8080/api/chandao-feishu.py?hook_url=https://open.feishu.cn/open-apis/bot/v2/hook/xxxx-xxxx-xxxx-xxxx

另外，禅道JSON消息中只有产品ID，没有产品名称，目前需要手动添加相关配置到scripts/api/chandao-feishu.py中。

## LICENSE

MIT

## 容器里使用报错

fork/exec gitcommand no such file or directory问题

python脚本的头文件 在docker里不存在，使用 which python3 命令查看在docker中python的位置，修改头文件即可