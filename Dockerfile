FROM debian
RUN apt update
RUN apt install ssh wget -y
RUN wget https://github.com/cloudflare/cnux-amd64.debleases/latest/download/cloudflared-linux-amd64.deb -O ./cloudflare.deb
RUN dpkg -i cloudflare.deb
RUN echo 'cloudflared service install eyJhIjoiYmM3YWE0NThkODFlZjgwMWZhYTg2ODBiYmI2NTUzZTUiLCJ0IjoiNGZiNzhmMTUtMWQzMy00NjVmLWI1YzMtNmE5MGQxMGY5YTNkIiwicyI6Ik56TTJPR05tTURrdE1XSmtZeTAwTVRreExUZzVOalF0T0dJM05qVmpNRGhsWW1JMiJ9' >>/1.sh
RUN chmod 755 /1.sh
CMD  /1.sh
