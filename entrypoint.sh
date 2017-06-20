#!/bin/sh
set -e

# Configure elasticsearch hosts in curator.yml
# client:
#   hosts:
#     - 10.1.1.1
#     - 10.1.1.2
#
# Elasticsearch hosts are passed in as a comma separated list, 10.1.1.1,10.1.1.2
ELASTICSEARCH_HOST=${ELASTICSEARCH_HOST:-localhost}
ELASTICSEARCH_PORT=${ELASTICSEARCH_PORT:-9200}
RETENTION_DAYS=${RETENTION_DAYS:-45}

#hosts="\    - ""`echo $ELASTICSEARCH_HOSTS | sed -e 's/,/\\\n    - /g'`"
#sed -i "/hosts:/a ${hosts}" /curator/config/curator.yml
sed -i "s/hosts: .*$/hosts: ${ELASTICSEARCH_HOST}/" /curator/config/curator.yml
sed -i "s/port: .*$/port: ${ELASTICSEARCH_PORT}/" /curator/config/curator.yml
sed -i "s/unit_count: .*$/unit_count: ${RETENTION_DAYS}/" /curator/config/action.yml

exec "$@"
