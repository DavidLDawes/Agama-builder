FROM node:8-slim
COPY auto-respond.txt auto-respond.txt
RUN apt -y update && apt -y install apt-transport-https && \
dpkg --add-architecture i386 && wget -nc https://dl.winehq.org/wine-builds/Release.key && \
apt-key add Release.key && echo "deb https://dl.winehq.org/wine-builds/debian/ jessie main" >> /etc/apt/sources.list && \
apt -y update && apt -y install --install-recommends winehq-stable &&  \ 
wget https://installbuilder.bitrock.com/installbuilder-enterprise-18.5.2-linux-x64-installer.run && \
chmod +x installbuilder-enterprise-18.5.2-linux-x64-installer.run && \
cat auto-respond.txt | ./installbuilder-enterprise-18.5.2-linux-x64-installer.run


CMD [ "/bin/bash" ]
