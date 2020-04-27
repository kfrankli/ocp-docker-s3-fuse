#!/bin/bash

export S3_ACL=${S3_ACL:-private}

export AWSACCESSKEYID=${AWSACCESSKEYID:-$AWS_ACCESS_KEY_ID}
export AWSSECRETACCESSKEY=${AWSSECRETACCESSKEY:-$AWS_SECRET_ACCESS_KEY}

mkdir -p ${MOUNT_POINT}

/usr/bin/s3fs ${S3_BUCKET} ${MOUNT_POINT} -o nosuid,nonempty,nodev,allow_other,default_acl=${S3_ACL},retries=5

exec "$@"
