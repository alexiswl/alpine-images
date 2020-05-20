# Slimming an image

[docker slim](https://github.com/docker-slim/docker-slim) works by looking through the tests that you run and keeping ONLY the code that you need.  
Since pandas doesn't import everything initially, we cannot simply leave the test file as `import pandas as pd`.  
Although we set `runner.sh` as the entrypoint, this does not remain the entrypoint on the slimmed image.

The code below creates the slimmed image by running through all of the python scripts in the test folder.  
The final slimmed image (121 Mb - compressed 37 Mb) is approximately half that of the original image (211 Mb - compressed 80 Mb).

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock dslim/docker-slim \
  --in-container build \
  --http-probe=false \
  --mount $PWD/tests/:/mnt/tests \
  --entrypoint /mnt/tests/runner.sh \
  --tag alexiswl/alpine_pandas:1.0.3-slim \
  alexiswl/alpine_pandas:1.0.3 && \
docker tag \
    alexiswl/alpine_pandas:1.0.3-slim \
    alexiswl/alpine_pandas:latest-slim && \
docker push alexiswl/alpine_pandas
```

Eventually I'll move this test folder out to a per repo and then in addition have a 'per' tag folder for additional tests specific to a tag.

# CWL Image
The cwl image is identical to the regular image however uses /bin/bash as an entry point.