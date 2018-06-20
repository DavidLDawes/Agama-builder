FROM node:8.11-alpine

RUN apk update && apk add --no-cache wine git wget bash

RUN wget http://winetricks.org/winetricks && chmod +x winetricks && mv winetricks /usr/bin/winetricks && \
wget https://installbuilder.bitrock.com/installbuilder-enterprise-18.5.2-linux-x64-installer.run && \
chmod +x installbuilder-professional-18.4.0-linux-installer.run && ./installbuilder-professional-18.4.0-linux-installer.run
							    

# Default execute the entrypoint
CMD ["/bin/bash"]
