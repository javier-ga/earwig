#!/bin/bash

TAG_VERSION=0.2

docker build -t jc_dp/earwig-crawler:$TAG_VERSION .
$(aws ecr get-login --no-include-email --region us-west-2)
docker tag jc_dp/earwig-crawler:$TAG_VERSION 067378203779.dkr.ecr.us-west-2.amazonaws.com/jc_dp/earwig-crawler:$TAG_VERSION
docker push 067378203779.dkr.ecr.us-west-2.amazonaws.com/jc_dp/earwig-crawler:$TAG_VERSION