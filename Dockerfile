# From base OS image
FROM eason02/centos:7.2

MAINTAINER Eason Lau <eason.lau02@hotmail.com>

COPY docker-entrypoint.sh /

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.3.1-x86_64.rpm && \
	rpm -vi filebeat-5.3.1-x86_64.rpm && \
	rm -f  /etc/filebeat/filebeat.yml && \
	mkdir -p /etc/filebeat/logs && \
	mkdir -p /etc/filebeat/data && \
	chmod +x /docker-entrypoint.sh

ENV PATH  /usr/share/filebeat/bin:$PATH

VOLUME /etc/filebeat/logs
VOLUME /etc/filebeat/data

WORKDIR /etc/filebeat/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["filebeat","-e"]
