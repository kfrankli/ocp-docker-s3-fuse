FROM ubi7/ubi:latest

ENV MOUNT_POINT=/var/s3
VOLUME /var/s3

RUN yum install s3fs-fuse -y

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
USER 1001
