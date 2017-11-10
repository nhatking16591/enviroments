#!/bin/bash
type=freeipa
name=${type}_${1}
docker build --build-arg TYPE_PUPPET=$type --rm -t king/puppet .
id=$(docker run -v /home/king/environments/puppet:/etc/puppet -ti -d --privileged --name=$name --hostname=${type}.test.king king/puppet /usr/sbin/init 3)
docker exec -ti $id "/init.sh"
docker exec -ti $id /bin/bash
