FROM node:8-slim
COPY auto-respond.txt auto-respond.txt

RUN apt-get update -y && apt-get install apt-transport-https git unzip curl && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    dpkg --add-architecture i386 && \
    wget -nc https://dl.winehq.org/wine-builds/Release.key && \
    apt-key add Release.key && echo "deb https://dl.winehq.org/wine-builds/debian/ jessie main" >> /etc/apt/sources.list && \
    apt -y update && apt -y install --install-recommends winehq-stable google-cloud-sdk &&  \ 
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://installbuilder.bitrock.com/installbuilder-enterprise-18.5.2-linux-x64-installer.run && \
    chmod +x installbuilder-enterprise-18.5.2-linux-x64-installer.run && \
    cat auto-respond.txt | ./installbuilder-enterprise-18.5.2-linux-x64-installer.run && \
    rm installbuilder-enterprise-18.5.2-linux-x64-installer.run && rm Release.key && \
    mkdir -p home && \
    ln -s opt/installbuilder-18.5.2/output/* /home/

ENV PATH "$PATH:/opt/installbuilder-18.5.2/bin/"
WORKDIR /home
VOLUME [ "/home/" ]

CMD [ "/bin/bash" ]
