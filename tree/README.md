Slimming the image
```bash

LATEST_VERSION=1.8.0

docker run -v /var/run/docker.sock:/var/run/docker.sock dslim/docker-slim \
  --in-container build \
  --http-probe=false \
  --tag alexiswl/alpine_tree:1.8.0-slim \
  alexiswl/alpine_tree:1.8.0 && \
docker tag \
    alexiswl/alpine_tree:1.8.0-slim \
    alexiswl/alpine_tree:latest-slim && \
docker push alexiswl/alpine_tree
```