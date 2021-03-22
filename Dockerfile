#download once for multiarch build
FROM scratch as caching-downloader
ADD https://github.com/ec-/Quake3e/archive/refs/tags/latest.tar.gz /quake3e.tar.gz

FROM alpine:3.13.2 as builder
RUN apk add --no-cache --update linux-headers build-base curl-dev bash
COPY --from=caching-downloader / /tmp
WORKDIR /build
RUN tar -zxvf /tmp/quake3e.tar.gz --strip-components=1
RUN make install BUILD_SERVER=1 BUILD_CLIENT=0 DESTDIR=. TARGET_SERVER=quake3e.ded

# mount pk3 into /home/user/baseq3 and cfg into /home/user 
FROM alpine:3.13.2
MAINTAINER bademux
COPY --from=builder /build/quake3e.ded /usr/local/bin
EXPOSE 27960/udp
RUN adduser user --disabled-password
USER user
ENTRYPOINT ["quake3e.ded", "+set fs_homepath /home/user", "+set net_port 27960"]


