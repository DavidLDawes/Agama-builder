FROM node:8-slim
RUN apt -y update && apt -y install --install-recommends winehq-stable

CMD [ "/bin/bash" ]
