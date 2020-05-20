#!/usr/bin/bash

set -e

# Build standard docker file
docker build . \
  -f Dockerfile \
  -t alexiswl/alpine_pandas:1.0.3

# Tag as latest
docker tag \
  alexiswl/alpine_pandas:1.0.3 \
  alexiswl/alpine_pandas:latest


# Build cwl dockerfile
docker build . \
  -f Dockerfile-cwl \
  -t alexiswl/alpine_pandas:1.0.3-cwl

# Tag cwl as latest
docker tag \
  alexiswl/alpine_pandas:1.0.3-cwl \
  alexiswl/alpine_pandas:latest-cwl

# Create docker slim image
docker run -v /var/run/docker.sock:/var/run/docker.sock dslim/docker-slim \
  --in-container build \
  --http-probe=false \
  --mount $PWD/tests/:/mnt/tests \
  --entrypoint /mnt/tests/runner.sh \
  --tag alexiswl/alpine_pandas:1.0.3-slim \
  alexiswl/alpine_pandas:1.0.3 && \

# Tag slim
docker tag \
    alexiswl/alpine_pandas:1.0.3-slim \
    alexiswl/alpine_pandas:latest-slim && \

# Tag as UMCCR for each of the tags
tags=( "1.0.3" "latest" \
       "1.0.3-slim" "latest-slim" \
       "1.0.3-cwl" "latest-cwl" )

for tag in "${tags[@]}"; do
  docker tag \
    "alexiswl/alpine_pandas:${tag}" \
    "umccr/alpine_pandas:${tag}"
done

docker push alexiswl/alpine_pandas
docker push umccr/alpine_pandas