url=$(echo $1|sed "s/\/etc\///")
vi $url $2
