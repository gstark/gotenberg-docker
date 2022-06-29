FROM nginx

FROM gotenberg/gotenberg:7

COPY run.sh /home/gotenberg/run.sh
COPY password /home/gotenberg/default.htpasswd
COPY nginx.subst.conf /home/gotenberg/nginx.subst.conf

COPY --from=nginx /usr/sbin/nginx /usr/sbin/nginx
COPY --from=nginx /usr/bin/envsubst /usr/bin/envsubst

# We see errors for this directory so lets see if allowing
# everyone to write to it makes anything work better/different
RUN mkdir -p /tmp/env.d
RUN chmod a+rwx /tmp/env.d

# Default listen port
ENV PORT 3000

# Default log level
ENV LOG_LEVEL debug

ENTRYPOINT ["/bin/bash", "-c"]
CMD ./run.sh
