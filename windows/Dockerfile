FROM node:8.11-alpine

RUN apk update && apk add --no-cache wine git wget bash

RUN wget http://winetricks.org/winetricks && chmod +x winetricks && mv winetricks /usr/bin/winetricks 


								    

# Default execute the entrypoint
CMD ["/bin/bash"]
