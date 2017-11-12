freeipa_name=freeipa_
name=$1
if [ -z "$name" ]; then
	echo "!!!Please set arg"
	exit 1
fi

docker exec -ti $freeipa_name ipa host-del ${name}.test.king
docker kill ${name}_;docker rm ${name}_
