FROM rhel7:latest

ENV MOUNT_POINT=/var/s3
VOLUME /var/s3

#RUN yum install epel-release -y
#RUN yum install s3fs-fuse -y
RUN yum install automake fuse fuse-devel -y
RUN yum install gcc-c++ git libcurl-devel -y 
RUN yum install libxml2-devel make openssl-devel -y
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git 
RUN cd s3fs-fuse && \
 ./autogen.sh && \
 ./configure --prefix=/usr && \
 make && \
 make install && \
 rm -rf /var/cache/apk/*


COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
USER 1001
