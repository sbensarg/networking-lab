# small alpine image, busybox is already inside
FROM alpine:3.19

# extra tools like telnet and ifconfig
RUN apk add --no-cache busybox-extras

# no ip here, we set it later in each part
CMD ["/bin/sh"]
