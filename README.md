# ocp-docker-s3-fuse

This is a simple project that contains that demonstrates how to use the [FUSE based file system backed by Amazon S3 Bucket](https://github.com/s3fs-fuse/s3fs-fuse) inside of a Fedora based, Docker Container.

## Acknowledgments

In the best spirit of Open Source software, this is based off of the work of others. Including, but not limited to:

* [FUSE based file system backed by Amazon S3](https://github.com/s3fs-fuse/s3fs-fuse)
* [docker-s3fs](https://github.com/xueshanf/docker-s3fs)
* [alpine-s3fs](https://github.com/rjocoleman/docker-alpine-s3fs)

## Overview

This project contains:

* A trivial `Dockerfile` to build the container
* A `docker-entrypoint.sh` that will run the needed `/usr/bin/s3fs` commands
* A makefile to call the `Dockerfile` and run the container in interactive text mode

### Security Implications/Concerns

> :warning: **There is a non-trivial risk of container escape**: This project contains Dragons!


To run this Docker container in Red Hat OpenShift Container Platform, one would need to create a new [Security Context Constraint](https://docs.openshift.com/container-platform/3.6/admin_guide/manage_scc.html#provide-additional-capabilities) for the container definition to enable the additional Linux Kernel Capability and mount the host FUSE device.

### How to Run

To build the container, run:

```
make build
```

To run the built container in interactive text mode, run the following, specifying appropriate values for `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `S3_ACL`, and `S3_BUCKET`. You can get these by going to the [AWS Security Credentials Console](https://console.aws.amazon.com/iam/home?#/security_credentials) and creating a new Acces Key:

```
make AWS_ACCESS_KEY_ID='AK...ZQ' AWS_SECRET_ACCESS_KEY='+M...9R' S3_ACL='private' S3_BUCKET='kfrankli-ocp-test' shell
```

You could also call the docker command directly:

```
docker run --cap-add SYS_ADMIN --device /dev/fuse -it -e AWS_ACCESS_KEY_ID='AK...ZQ' -e AWS_SECRET_ACCESS_KEY='+M...9R' -e S3_ACL='private' -e S3_BUCKET='kfrankli-ocp-test' kfrankli/rhel7-s3-fuse:latest /bin/bash
```

You can also run the make `build` and `shell` targets with the `all` command

```
make AWS_ACCESS_KEY_ID='AK...ZQ' AWS_SECRET_ACCESS_KEY='+M...9R' S3_ACL='private' S3_BUCKET='kfrankli-ocp-test' all
```

Once it is running you should be able to see the conntents of your mapped S3 bucket under `/var/s3`. E.g.:

```
[root@hal9000 ocp-docker-s3-fuse]# make AWS_ACCESS_KEY_ID='AK...ZQ' AWS_SECRET_ACCESS_KEY='+M...9R' S3_ACL='private' S3_BUCKET='kfrankli-ocp-test' shell
[root@a96fce165a49 /]# cat /var/s3/data.txt
No one would have believed in the last years of the nineteenth century that this world was being watched keenly and closely by intelligences greater than man’s and yet as mortal as his own;
```
