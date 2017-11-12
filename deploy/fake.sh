#!/bin/bash
type=fake
domain=test.king
name=${type}_${1}
freeipa_name=freeipa_
docker build --build-arg TYPE_PUPPET=$type --rm -t king/puppet .
id=$(docker run -v /home/king/environments/puppet:/etc/puppet -ti -d --privileged --name=$name --hostname=${type}.${domain} king/puppet /usr/sbin/init 3)
pass=$(docker exec $freeipa_name /usr/bin/ipa host-add --force --random ${type}.${domain}|grep "Random password"|awk {"print \$3"})
echo $pass
docker exec -ti $id bash -c "/usr/bin/echo '$pass' > /etc/freeipa_pass; cat /etc/freeipa_pass"
docker exec $id "/init.sh"
docker exec -ti $id /bin/bash
