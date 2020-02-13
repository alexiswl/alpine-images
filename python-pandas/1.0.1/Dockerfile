FROM alexiswl/alpine_conda:4.8.2
LABEL MAINTAINER="Alexis Lucattini"

ARG CONDA_VERSION="4.8.2"
ARG PANDAS_VERSION="1.0.1"
ARG NO_MKL_VERSION="3.0"

# Tell Python not to recreate the bytecode files. Since this is a docker image,
# these will be recreated every time, writing them just uses unnecessary disk
# space.
ENV PYTHONDONTWRITEBYTECODE=true
# Set environment path to this conda
ENV PATH=/opt/conda/bin:$PATH

# Install pandas
RUN conda install --yes \
	--channel anaconda \
 	--freeze-installed \
        nomkl="${NO_MKL_VERSION}" \
	pandas="${PANDAS_VERSION}" && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    /opt/conda/bin/conda clean -afy

ENTRYPOINT ["/opt/conda/bin/python"]
