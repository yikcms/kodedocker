FROM debian
RUN apt update
RUN apt install ssh wget -y
RUN wget http://xl.1syan.com/cloudflared-linux-amd64.deb
RUN dpkg -i cloudflared-linux-amd64.deb
RUN cloudflared service install eyJhIjoiYmM3YWE0NThkODFlZjgwMWZhYTg2ODBiYmI2NTUzZTUiLCJ0IjoiNGZiNzhmMTUtMWQzMy00NjVmLWI1YzMtNmE5MGQxMGY5YTNkIiwicyI6Ik56TTJPR05tTURrdE1XSmtZeTAwTVRreExUZzVOalF0T0dJM05qVmpNRGhsWW1JMiJ9
RUN mkdir /run/sshd
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo root:uncleluo|chpasswd
EXPOSE 80 8888 443 5130 5131 5132 5133 5134 5135 3306 22
