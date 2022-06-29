FROM nginx

FROM gotenberg/gotenberg:7

COPY password /home/gotenberg/default.htpasswd
COPY nginx.subst.conf /home/gotenberg/nginx.subst.conf

COPY --from=nginx /usr/sbin/nginx /usr/sbin/nginx
COPY --from=nginx /usr/bin/envsubst /usr/bin/envsubst

# We see errors for this directory so lets see if allowing
# everyone to write to it makes anything work better/different
RUN mkdir -p /tmp/env.d
RUN chmod a+rwx /tmp/env.d

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash" , "-c", "(gotenberg --api-port 4000 --log-level $LOG_LEVEL &) && mkdir -p /var/log/nginx /var/cache/nginx && envsubst '\$PORT' < /home/gotenberg/nginx.subst.conf > /home/gotenberg/nginx.conf && cat /home/gotenberg/nginx.conf && nginx -c /home/gotenberg/nginx.conf"]
