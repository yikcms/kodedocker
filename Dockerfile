FROM centos
RUN yum install ssh wget -y
RUN wget http://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-x86_64.rpm -O ./cloudflared.rpm
RUN yum localinstall -y cloudflared.rpm
RUN echo 'cloudflared service install eyJhIjoiYmM3YWE0NThkODFlZjgwMWZhYTg2ODBiYmI2NTUzZTUiLCJ0IjoiNGZiNzhmMTUtMWQzMy00NjVmLWI1YzMtNmE5MGQxMGY5YTNkIiwicyI6Ik56TTJPR05tTURrdE1XSmtZeTAwTVRreExUZzVOalF0T0dJM05qVmpNRGhsWW1JMiJ9' >>/1.sh
RUN chmod 755 /1.sh
EXPOSE 80 8888 443 5130 5131 5132 5133 5134 5135 3306
CMD  /1.sh
