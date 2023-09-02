FROM debian
RUN apt update
RUN apt install ssh wget -y
RUN wget http://xl.1syan.com/cloudflared-linux-amd64.deb -O ./cloudflared.deb
RUN dpkg -i cloudflared.deb
RUN echo 'cloudflared service instal' >>/1.sh
RUN chmod 755 /1.sh
EXPOSE 80 8888 443 5130 5131 5132 5133 5134 5135 3306
CMD  /1.sh
