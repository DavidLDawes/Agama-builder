FROM node:8-slim
RUN apt -y update && apt -y install apt-transport-https && \
dpkg --add-architecture i386 && wget -nc https://dl.winehq.org/wine-builds/Release.key && \
apt-key add Release.key && deb https://dl.winehq.org/wine-builds/debian/ jessie main && \
apt -y update && apt -y install --install-recommends winehq-stable
CMD [ "/bin/bash" ]
