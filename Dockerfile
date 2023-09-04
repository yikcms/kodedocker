# 使用 Debian 作为基础镜像
FROM couchbase/centos7-systemd


# 更新系统并安装所需软件包
RUN yum update \
    && yum install -y openssh-server wget

# 配置 SSH
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd   # 替换 "password" 为你想要的密码

# 开启 SSH 远程登录
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config

# 安装 frpc
RUN wget https://github.com/fatedier/frp/releases/download/v0.37.1/frp_0.37.1_linux_amd64.tar.gz
RUN tar -xzvf frp_0.37.1_linux_amd64.tar.gz
RUN unlink frp_0.37.1_linux_amd64.tar.gz
RUN mv frp_0.37.1_linux_amd64 /frp

RUN unlink /frp/frpc.ini
RUN echo '[common]' >> /frp/frpc.ini \
&& echo 'server_addr = 172.245.159.187' >> /frp/frpc.ini \
&& echo 'server_port = 7000' >> /frp/frpc.ini \
&& echo ' ' >> /frp/frpc.ini \
&& echo '[ssh]' >> /frp/frpc.ini \
&& echo 'type = tcp' >> /frp/frpc.ini \
&& echo 'local_ip = 127.0.0.1' >> /frp/frpc.ini \
&& echo 'local_port = 22' >> /frp/frpc.ini \
&& echo 'remote_port = 6000' >> /frp/frpc.ini

# 启动 SSH 服务
CMD sh -c "/usr/sbin/sshd && /frp/frpc -c /frp/frpc.ini"
