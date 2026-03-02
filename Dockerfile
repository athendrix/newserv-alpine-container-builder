FROM alpine:latest
WORKDIR /src
RUN apk add procps build-base git libevent-dev cmake zlib-dev icu-libs asio-dev && \
    git clone https://github.com/fuzziqersoftware/phosg.git && \
    cd /src/phosg && cmake . && make && make test && make install && cd .. && \
    rm -R /src/phosg && \
    git clone https://github.com/fuzziqersoftware/resource_dasm.git && \
    cd /src/resource_dasm && cmake . && make && make install && cd .. && \
    rm -R /src/resource_dasm && \
    git clone https://github.com/fuzziqersoftware/newserv.git && \
    cd /src/newserv && cmake . && make && cp system/maps/bb-v4/*.dat system/patch-bb/data && \
    apk del build-base git cmake && \
    adduser -HDu 1000 pso && \
    chown -R pso:pso /src/newserv && \
    mkdir /config && \
    ln -s /config/config.json system/config.json && \
    ln -s /config/players system/players && \
    ln -s /config/teams system/teams && \
    ln -s /config/licenses system/licenses 

WORKDIR /src/newserv

# Remove all the Blue Burst foreign language quests that have an English translation
# (Because otherwise, my Blue Burst Clients grab the Japanese versions)
RUN for lang in j g f s; do \
      find system/quests -name "*-${lang}.bin" -type f | while read lang_file; do \
        e_file="${lang_file%-${lang}.bin}-e.bin"; \
        if [ -f "$e_file" ]; then \
          rm "$lang_file"; \
        fi; \
      done; \
    done ; \
done;

# I personally only care about the GameCube versions and Blue Burst, so that's what I've exposed here.
# EXPOSE doesn't actually do anything for kubernetes deployments. So this is really just a reminder to me.
# For Gamecube DNS redirection
EXPOSE 53/udp
# For GC_V3-console-lobby-lobby_server
EXPOSE 5110/tcp
# For BB_V4-bb-lobby-lobby_server
EXPOSE 5112/tcp
# For GC_V3-gc-us12t1-login_server
EXPOSE 9064/tcp
# For GC_V3-gc-us10-login_server
EXPOSE 9100/tcp
# For GC_V3-gc-us3-login_server
EXPOSE 9103/tcp
# For PC_PATCH-bb-patch-patch_server_bb
EXPOSE 11000/tcp
# For BB_V4-init-login_server
EXPOSE 12000/tcp
# For BB_V4-bb-data1-login_server
EXPOSE 12004/tcp
# For BB_V4-bb-data2-login_server
EXPOSE 12005/tcp

CMD mkdir -p /config/players && mkdir -p /config/teams && mkdir -p /config/licenses && \
cp -n /src/newserv/system/config.example.json /config/config.json && chown -R pso:pso /config && \
type /config/autoexec.sh && chmod +x /config/autoexec.sh && /config/autoexec.sh; \
./newserv
