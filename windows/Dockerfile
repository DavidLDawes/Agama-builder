FROM node:10.15.0-stretch-slim
ENV CLOUD_SDK_VERSION=206.0.0 \
    ARG=INSTALL_COMPONENTS \
    WINE_MONO_VERSION=4.5.6
RUN apt-get update -qqy && apt-get install -qqy --no-install-recommends  apt-utils && \
    dpkg --add-architecture i386 && \
    apt-get install -qqy --no-install-recommends \
    curl \
    gcc \
    python-dev \
    python-setuptools \
    apt-transport-https \
    lsb-release \
    openssh-client \
    git \
    unzip \
    zip && \
    apt-get -y update && apt-get -y install --install-recommends wine && \
    easy_install -U pip && \
    pip install -U crcmod && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 $INSTALL_COMPONENTS && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    curl -SL 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -o /usr/local/bin/winetricks && \
    chmod +x /usr/local/bin/winetricks && \
    mkdir -p /usr/share/wine/mono && \
	curl -SL 'http://sourceforge.net/projects/wine/files/Wine%20Mono/$WINE_MONO_VERSION/wine-mono-$WINE_MONO_VERSION.msi/download' -o /usr/share/wine/mono/wine-mono-$WINE_MONO_VERSION.msi && \
	chmod +x /usr/share/wine/mono/wine-mono-$WINE_MONO_VERSION.msi && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]