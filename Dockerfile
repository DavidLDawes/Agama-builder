FROM node:8-slim
RUN dpkg --add-architecture i386 && wget -nc https://dl.winehq.org/wine-builds/Release.key && \
apt-key add Release.key && deb https://dl.winehq.org/wine-builds/debian/ DISTRO main && \
apt -y update && apt -y install --install-recommends winehq-stable
CMD [ "/bin/bash" ]
