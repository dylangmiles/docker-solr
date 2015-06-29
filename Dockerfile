FROM java:8-jre

MAINTAINER Dylan Miles <dylan.g.miles@gmail.com>

#
## install required utils
RUN [ -e /etc/opkg.conf ] && opkg-install bash; [ -e /bin/bash ]
RUN [ -e /usr/bin/apt-get ] && apt-get update && apt-get install -y patch unzip && apt-get clean all; which unzip && which patch
##
#

#
## SOLR INSTALLATION
ENV SOLR_VERSION 3.6.2
ENV SOLR apache-solr-$SOLR_VERSION
ADD http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz /tmp/$SOLR.tgz
RUN mkdir -p /opt \
 && gzip -dc /tmp/$SOLR.tgz | tar -C /opt -x \
 && ln -sf /opt/$SOLR /opt/solr \
 && rm /tmp/$SOLR.tgz
##
#


EXPOSE 8983
WORKDIR /opt/solr/example
CMD ["/bin/bash", "-c", "cd /opt/solr/example; java -jar start.jar"]


