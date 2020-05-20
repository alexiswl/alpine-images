#!/usr/bin/bash

set -e

VERSION="1.0.1"
IS_LATEST=false

# Build standard docker file
docker build . \
  -f Dockerfile \
  -t "alexiswl/alpine_pandas:${VERSION}"

if [[ "${IS_LATEST}" == true ]]; then
  # Tag as latest
  docker tag \
    "alexiswl/alpine_pandas:${VERSION}" \
    "alexiswl/alpine_pandas:latest"
fi

# Build cwl dockerfile
docker build . \
  -f Dockerfile-cwl \
  -t "alexiswl/alpine_pandas:${VERSION}-cwl"

if [[ "${IS_LATEST}" == true ]]; then
  # Tag cwl as latest
  docker tag \
    "alexiswl/alpine_pandas:${VERSION}-cwl" \
    "alexiswl/alpine_pandas:latest-cwl"
fi

# Create docker slim image
docker run -v /var/run/docker.sock:/var/run/docker.sock dslim/docker-slim \
  --in-container build \
  --http-probe=false \
  --mount "$PWD/tests/:/mnt/tests" \
  --entrypoint /mnt/tests/runner.sh \
  --tag "alexiswl/alpine_pandas:${VERSION}-slim" \
  "alexiswl/alpine_pandas:${VERSION}"

if [[ "${IS_LATEST}" == true ]]; then
  # Tag slim
  docker tag \
      "alexiswl/alpine_pandas:${VERSION}-slim" \
      "alexiswl/alpine_pandas:latest-slim"
fi

# Tag as UMCCR for each of the tags
tags=( "${VERSION}" \
       "${VERSION}-slim" \
       "${VERSION}-cwl" )

for tag in "${tags[@]}"; do
  docker tag \
    "alexiswl/alpine_pandas:${tag}" \
    "umccr/alpine_pandas:${tag}"
done

if [[ "${IS_LATEST}" == true ]]; then
  tags=( "latest" \
         "latest-slim" \
         "latest-cwl" )
  docker tag \
    "alexiswl/alpine_pandas:${tag}" \
    "umccr/alpine_pandas:${tag}"
fi

# Push both
docker push alexiswl/alpine_pandas
docker push umccr/alpine_pandas