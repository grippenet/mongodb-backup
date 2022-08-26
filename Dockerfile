FROM bitnami/minideb:bullseye

COPY install.sh .
RUN chmod u+x install.sh
RUN ./install.sh

CMD [ "/bin/bash" ]