FROM ubuntu:14.04
MAINTAINER Chelsea Zhang <chelsea@bluelabs.com>

# Based on https://github.com/barnybug/dockerfiles/blob/master/elasticsearch/Dockerfile
# and https://github.com/dockerfile/elasticsearch/blob/master/Dockerfile

RUN apt-get update && \
    apt-get -qy install wget openjdk-7-jre-headless && \
    apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
CMD java -version

RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.tar.gz && \
  tar xvzf elasticsearch-1.4.4.tar.gz && \
  rm -f elasticsearch-1.4.4.tar.gz && \
  mv /tmp/elasticsearch-1.4.4 /elasticsearch && \
  /elasticsearch/bin/plugin -install elasticsearch/elasticsearch-cloud-aws/2.2.0 && \
  /elasticsearch/bin/plugin -install lukas-vlcek/bigdesk/2.4.1

ENV ES_CONF /elasticsearch/config/elasticsearch.yml
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

VOLUME /data

WORKDIR /data

EXPOSE 9200 9300

CMD /elasticsearch/bin/elasticsearch -Des.config=$ES_CONF
