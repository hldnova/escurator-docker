# Docker image for elastic curator on Ubuntu Linux.

FROM lidaheemc/supervisord
MAINTAINER Lida He, https://github.com/hldnova

ENV ES_CURATOR_VERSION=5.0.4

RUN apt update && \
    pip install -U elasticsearch-curator==${ES_CURATOR_VERSION} && \
    mkdir -p /curator && \
# Clean up.
    rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf ~/.cache 


WORKDIR /curator
COPY curator.yml /curator/
COPY action.yml /curator/
COPY supervisord-curator.conf /etc/supervisor.d/
COPY entrypoint.sh /curator/entrypoint.sh

ENTRYPOINT ["/curator/entrypoint.sh"]
