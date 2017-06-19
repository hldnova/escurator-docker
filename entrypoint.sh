#!/bin/sh
set -e

# Configure elasticsearch hosts in curator.yml
# client:
#   hosts:
#     - 10.1.1.1
#     - 10.1.1.2
#
# Elasticsearch hosts are passed in as a comma separated list, 10.1.1.1,10.1.1.2
ELASTICSEARCH_HOSTS=${ELASTICSEARCH_HOSTS:-localhost}
ELASTICSEARCH_HOSTS=${ELASTICSEARCH_PORT:-9200}
RETENTION_DAYS=${RETENTION_DAYS:-45}

hosts="\    - ""`echo $ELASTICSEARCH_HOSTS | sed -e 's/,/\\\n    - /g'`"
sed -i "/hosts:/a ${hosts}" curator.yml
sed -i "s/port: .*$/port: ${ELASTICSEARCH_PORT}/" curator.yml
sed -i "s/unit_count: .*$/unit_count: ${RETENTION_DAYS}/" action.yml

exec "$@"
