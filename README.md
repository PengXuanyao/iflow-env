## iFlow使用

### 获取镜像

1. 自行构建；
   * 源脚本地址为：[gist.github链接](https://gist.github.com/0xharry/bf336298d4aa344f8262ab940ae63d69)
   * 使用`docker build -t iflow .`
   * 不推荐，构建出来的镜像调用host的x11进行图形显示出现问题，不能正常展示klayout界面。
2. 从dockerhub获取：
   * 源镜像地址为iedaopensource/iflow
   * 微调后在centos7环境下能够良好运行的版本crabyao/ifow:stable
   * 使用`docker-compose up -d`自动获取镜像和运行容器
   * 后续基于**从dockerhub获取crabyao/iflow:stable**版本步骤操作

### 运行容器

在获取docker镜像后，使用命令进入docker：

```bash
docker-compose exec iflow bash
```

进入容器后运行生成后端文件的脚本：

```bash
./run_flow.py -d aes_cipher_top -s synth,floorplan,tapcell,pdn,gplace,resize,dplace,cts,filler,groute,droute,layout -f sky130 -t HS -c TYP -v V1 -l V1
```

> 使用docker compose和docker run的区别：
1. docker compose可以每次**docker compose up**运行即可，而**不会重复创建镜像**。
2. 但是如果使用**docker run会创建重复的容器**，比较麻烦。
> 

如果出现报错：

libQt5Core.so.5:cannot open shared object file: No such file or directory

在网上找到解决办法，在容器中运行：

```bash
strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
```

最后会打开klayout正常显示gds版图文件。

![iflow生成版图](https://s2.loli.net/2024/04/04/jabIEiw7Y6OUPRg.png)

### 参考链接

* [iflow](https://gitee.com/oscc-project/iFlow) -- iflow 相关操作指令解释在此仓库的README中
* [iEDA](https://gitee.com/oscc-project/iEDA)
