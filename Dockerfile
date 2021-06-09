FROM ubuntu:18.04
ADD version_list.txt /version_list.txt
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
