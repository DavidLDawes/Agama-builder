FROM node:8-slim
RUN apt -y update && apt install --install-recommends winehq-stable

CMD [ "/bin/bash" ]
