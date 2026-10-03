FROM alpine:3.19

# frr gives us zebra, bgpd, ospfd and isisd
RUN apk add --no-cache \
    frr \
    frr-pythontools \
    busybox-extras

# turn on bgp, ospf and isis
RUN sed -i \
    -e 's/^bgpd=no/bgpd=yes/' \
    -e 's/^ospfd=no/ospfd=yes/' \
    -e 's/^isisd=no/isisd=yes/' \
    /etc/frr/daemons

# our router config (owned by frr so the daemons can read it)
COPY --chown=frr:frr frr.conf vtysh.conf /etc/frr/

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
