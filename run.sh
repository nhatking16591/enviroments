docker rmi -f $(docker images --filter "dangling=true")
docker build --rm -t king/puppet .
docker run -ti -d --privileged=true king/puppet
