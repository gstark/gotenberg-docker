#!/bin/bash -x

gotenberg --api-port 4000 --log-level $LOG_LEVEL &
envsubst '\$PORT' < /home/gotenberg/nginx.subst.conf > /home/gotenberg/nginx.conf
# cat /home/gotenberg/nginx.conf
nginx -c /home/gotenberg/nginx.conf
