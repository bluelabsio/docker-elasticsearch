FROM ubuntu:14.04
MAINTAINER Chelsea Zhang <chelsea@bluelabs.com>

# Based on https://github.com/barnybug/dockerfiles/blob/master/elasticsearch/Dockerfile
# and https://github.com/dockerfile/elasticsearch/blob/master/Dockerfile

RUN apt-get update && apt-get clean
RUN apt-get -y install wget

RUN apt-get install -q -y openjdk-7-jre-headless && apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
CMD java -version

RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.2.tar.gz && \
  tar xvzf elasticsearch-1.2.2.tar.gz && \
  rm -f elasticsearch-1.2.2.tar.gz && \
  mv /tmp/elasticsearch-1.2.2 /elasticsearch

ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

VOLUME /data

WORKDIR /data

EXPOSE 9200 9300

CMD /elasticsearch/bin/elasticsearch