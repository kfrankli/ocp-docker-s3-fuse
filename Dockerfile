FROM fedora:latest
USER 1001
ENV MOUNT_POINT=/var/s3
VOLUME /var/s3

RUN dnf install s3fs-fuse -y

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
