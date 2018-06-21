FROM node:8-slim
RUN apt -y update && apt -y install apt-transport-https && \
dpkg --add-architecture i386 && wget -nc https://dl.winehq.org/wine-builds/Release.key && \
apt-key add Release.key && echo "deb https://dl.winehq.org/wine-builds/debian/ jessie main" >> /etc/apt/sources.list && \
apt -y update && apt -y install --install-recommends winehq-stable
CMD [ "/bin/bash" ]
