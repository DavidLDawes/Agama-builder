FROM node:8-slim
RUN apt -y update && \
	DEBIAN_FRONTEND=noninteractive apt -y install software-properties-common apt-transport-https && \
	curl -fsSL https://dl.winehq.org/wine-builds/Release.key | apt-key add - && \
	dpkg --add-architecture i386 && \
	add-apt-repository https://dl.winehq.org/wine-builds/ubuntu/ && \
	apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install --install-recommends winehq-stable && \
    wget https://installbuilder.bitrock.com/installbuilder-enterprise-18.5.2-linux-x64-installer.run && \
    chmod +x installbuilder-enterprise-18.5.2-linux-x64-installer.run && \
    ./installbuilder-enterprise-18.5.2-linux-x64-installer.run
    

CMD [ "/bin/bash" ]
