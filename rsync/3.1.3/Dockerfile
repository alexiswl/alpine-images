FROM alpine:3.9.5

LABEL MAINTAINER="Alexis Lucattini"

# Install rsync on alpine
ARG RSYNC_VERSION="3.1.3-r1"
ARG ALPINE_MAIN_REPOSITORY="http://dl-cdn.alpinelinux.org/alpine/v3.9/main/"

RUN apk add \
	--no-cache \
        --repository "${ALPINE_MAIN_REPOSITORY}" \
	rsync="${RSYNC_VERSION}" \
	bash \
	openssh

ENTRYPOINT ["rsync"]
CMD ["--help"]
