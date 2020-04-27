.PHONY: build shell

all: build shell

build:
	@docker build -t kfrankli/rhel7-s3-fuse:latest .

shell:
	@docker run --cap-add SYS_ADMIN --device /dev/fuse -it -e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) -e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) -e S3_ACL=$(S3_ACL) -e S3_BUCKET=$(S3_BUCKET) kfrankli/rhel7-s3-fuse:latest /bin/bash
