FROM baiyuetribe/kodexplorer
RUN apk update && \
    apk add --no-cache openssh tzdata && \ 
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
       ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
    echo "root:admin" | chpasswd && \
    wget https://github.com/fatedier/frp/releases/download/v0.37.1/frp_0.37.1_linux_amd64.tar.gz &&\
    tar -xzvf frp_0.37.1_linux_amd64.tar.gz &&\
    unlink frp_0.37.1_linux_amd64.tar.gz &&\
    mv frp_0.37.1_linux_amd64 /frp
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
RUN apk add openrc && \
apk add --no-cache curl && \
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
chmod +x /usr/local/bin/cloudflared
CMD ["/bin/sh", "-c", "/usr/sbin/sshd -D & /frp/frpc -c /frp/frpc.ini & php -S 0.0.0.0:80 -t /var/www/html > /dev/null 2>&1"]
