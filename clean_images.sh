docker rmi -f $(docker images --filter "dangling=true")
