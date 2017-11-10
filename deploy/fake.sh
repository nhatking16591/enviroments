#!/bin/bash
type=fake
name=${type}_${1}
docker build --build-arg TYPE_PUPPET=$type --rm -t king/puppet .
id=$(docker run -v /home/king/environments/king-puppet:/etc/king-puppet -ti -d --privileged --name=$name --hostname=freeipa.test.king king/puppet)
docker exec -ti $id /bin/bash

