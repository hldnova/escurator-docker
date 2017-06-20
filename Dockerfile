# Docker image for elastic curator on Ubuntu Linux.

FROM lidaheemc/supervisord
MAINTAINER Lida He, https://github.com/hldnova

ENV ES_CURATOR_VERSION=5.0.4

RUN apt update && \
    pip install -U elasticsearch-curator==${ES_CURATOR_VERSION} && \
    mkdir -p /curator/logs && \
# Clean up.
    rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf ~/.cache 


WORKDIR /curator
COPY curator.yml /curator/config/
COPY action.yml /curator/config/
COPY supervisord-curator.conf /etc/supervisor/conf.d/
COPY entrypoint.sh /curator/entrypoint.sh

ENTRYPOINT ["/curator/entrypoint.sh"]

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
