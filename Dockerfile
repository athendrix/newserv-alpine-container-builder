FROM alpine:latest AS base
RUN apk add procps
WORKDIR /app

FROM base AS build
WORKDIR /src
RUN apk add build-base git libevent-dev cmake zlib-dev && \
    git clone https://github.com/fuzziqersoftware/phosg.git && \
    git clone https://github.com/fuzziqersoftware/resource_dasm.git && \
    git clone https://github.com/fuzziqersoftware/newserv.git
WORKDIR /src/phosg
RUN cmake . && make && make test && make install
WORKDIR /src/resource_dasm
RUN cmake . && make && make install
WORKDIR /src/newserv
RUN cmake . && make && cp system/maps/bb-v4/*.dat system/patch-bb/data

RUN mkdir /config && \
    ln -s /config/config.json system/config.json && \
    ln -s /config/players system/players && \
    ln -s /config/teams system/teams && \
    ln -s /config/licenses system/licenses

# For Gamecube DNS redirection
EXPOSE 53/udp
# For GC_V3-gc-us12t1-login_server
EXPOSE 9064/tcp
# For GC_V3-gc-us10-login_server
EXPOSE 9100/tcp
# For GC_V3-gc-us3-login_server
EXPOSE 9103/tcp
# For BB_V4-bb-lobby-lobby_server
EXPOSE 5112/tcp
# For BB_V4-bb-data1-login_server
EXPOSE 12004/tcp
# For PC_PATCH-bb-patch-patch_server_bb
EXPOSE 11000/tcp
# For BB_V4-init-login_server
EXPOSE 12000/tcp
# For GC_V3-console-lobby-lobby_server
EXPOSE 5110/tcp
# For BB_V4-bb-data2-login_server
EXPOSE 12005/tcp

CMD mkdir -p /config/players && mkdir -p /config/teams && mkdir -p /config/licenses && ./newserv