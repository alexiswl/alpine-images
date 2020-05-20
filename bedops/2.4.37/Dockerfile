FROM alpine:3.9.5

LABEL MAINTAINER="Alexis Lucattini"

# Install rsync on alpine
ARG BEDOPS_VERSION="2.4.37"
ARG BEDOPS_FILE="bedops_linux_x86_64-v${BEDOPS_VERSION}.tar.bz2"
ARG ALPINE_MAIN_REPOSITORY="http://dl-cdn.alpinelinux.org/alpine/v3.9/main/"
ENV PATH="/opt/bedops/bin:$PATH"

RUN apk add \
	    --no-cache \
        --repository "${ALPINE_MAIN_REPOSITORY}" \
	    ca-certificates \
	    bash \
	    openssh \
	    wget \
	    tar \
	    bzip2 && \
	    mkdir -p /opt/bedops/ && \
	    wget "https://github.com/bedops/bedops/releases/download/v${BEDOPS_VERSION}/${BEDOPS_FILE}" && \
	    tar -C /opt/bedops/ -xf "${BEDOPS_FILE}" && \
	    rm "${BEDOPS_FILE}

ENTRYPOINT ["bedops"]
CMD ["--help"]
