FROM fedora:latest
ENV MOUNT_POINT=/var/s3
VOLUME ${MOUNT_POINT}

RUN dnf install s3fs-fuse -y

RUN chgrp -R 0 ${MOUNT_POINT} && \
    chmod -R g+rwX ${MOUNT_POINT}

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
USER 1001
