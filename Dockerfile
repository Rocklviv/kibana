FROM alpine
MAINTAINER Denys Chekirda <dchekirda@gmail.com>

ENV KIBANA_VERSION 4.5.0

RUN apk add --update nodejs curl && \
    curl -LO https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
    tar xzf /kibana-${KIBANA_VERSION}-linux-x64.tar.gz -C / && \
    rm /kibana-${KIBANA_VERSION}-linux-x64/node/bin/node && \
    rm /kibana-${KIBANA_VERSION}-linux-x64/node/bin/npm && \
    ln -s /usr/bin/node /kibana-${KIBANA_VERSION}-linux-x64/node/bin/node && \
    ln -s /usr/bin/npm /kibana-${KIBANA_VERSION}-linux-x64/node/bin/npm && \
    echo 'elasticsearch.url: "http://elasticsearch:9200"' >> /kibana-${KIBANA_VERSION}-linux-x64/config/kibana.yml &&\
    rm -rf /var/cache/apk/* /kibana-${KIBANA_VERSION}-linux-x64.tar.gz

EXPOSE 5601
WORKDIR kibana-${KIBANA_VERSION}-linux-x64
CMD ["bin/kibana"]
