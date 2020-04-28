FROM registry.access.redhat.com/ubi7/ubi:latest

ENV MOUNT_POINT=/var/s3
VOLUME /var/s3

#RUN yum install s3fs-fuse -y
RUN yum install automake fuse fuse-devel gcc-c++ git libcurl-devel libxml2-devel make
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git; \
 cd s3fs-fuse; \
 ./autogen.sh; \
 ./configure --prefix=/usr; \
 make; \
 make install; \
 rm -rf /var/cache/apk/*;


COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
USER 1001
