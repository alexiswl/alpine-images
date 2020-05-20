FROM frolvlad/alpine-glibc:alpine-3.9_glibc-2.29
LABEL MAINTAINER_ORIGIN="Jim Crist"
LABEL MAINTAINER="ALexis Lucattini"

ARG CONDA_VERSION=4.8.2
ARG CONDA_PATCH_VERSION=4.7.12.1
ARG CONDA_FILENAME=Miniconda3-$CONDA_PATCH_VERSION-Linux-x86_64.sh
ARG CONDA_FILENAME_MD5=81c773ff87af5cfac79ab862942ab6b3

# Tell Python not to recreate the bytecode files. Since this is a docker image,
# these will be recreated every time, writing them just uses unnecessary disk
# space.
ENV PYTHONDONTWRITEBYTECODE=true
# Set environment path to this conda
ENV PATH=/opt/conda/bin:$PATH

# We do the following all in one block:
# - Create user and group anaconda
# - Install miniconda install dependencies
# - Download miniconda and check the md5sum
# - Install miniconda
# - Install tini
# - Remove all conda managed static libraries
# - Remove all conda managed *.pyc files
# - Cleanup conda files
# - Uninstall miniconda install dependencies
# Allow chown into opt so that the user can write/ create additional installations

RUN apk add --no-cache wget bzip2 bash findutils ca-certificates git openssh-client openssh \
    && addgroup -S anaconda \
    && adduser -D -u 10151 anaconda -G anaconda \
    && wget --quiet https://repo.continuum.io/miniconda/${CONDA_FILENAME} \
    && echo "${CONDA_FILENAME_MD5}  ${CONDA_FILENAME}" > miniconda.md5 \
    && if [ $(md5sum -c miniconda.md5 | awk '{print $2}') != "OK" ] ; then exit 1; fi \
    && mv ${CONDA_FILENAME} miniconda.sh \
    && sh ./miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh miniconda.md5 \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/anaconda/.profile \
    && echo "conda activate base" >> /home/anaconda/.profile \
    && /opt/conda/bin/conda install conda==$CONDA_VERSION \
    && echo "conda==$CONDA_VERSION" >> /opt/conda/conda-meta/pinned \
    && /opt/conda/bin/conda install --freeze-installed tini -y \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && /opt/conda/bin/conda clean -afy \
    && chown -R anaconda:anaconda /opt/ \
    && apk del wget bzip2

COPY start.sh /usr/local/bin/

ENTRYPOINT ["/opt/conda/bin/tini", "-g", "--", "/usr/local/bin/start.sh"]
CMD ["sh", "--login", "-i"]
