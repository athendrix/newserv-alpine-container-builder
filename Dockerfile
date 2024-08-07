FROM alpine:latest
WORKDIR /src
RUN apk add procps build-base git libevent-dev cmake zlib-dev icu-libs && \
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

# Remove all the Blue Burst Japanese quests that have an English translation
RUN rm -f system/quests/battle/b88001-bb-j.bin && \
    rm -f system/quests/battle/b88002-bb-j.bin && \
    rm -f system/quests/battle/b88003-bb-j.bin && \
    rm -f system/quests/battle/b88004-bb-j.bin && \
    rm -f system/quests/battle/b88005-bb-j.bin && \
    rm -f system/quests/battle/b88006-bb-j.bin && \
    rm -f system/quests/battle/b88007-bb-j.bin && \
    rm -f system/quests/battle/b88008-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88101-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88102-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88103-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88104-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88105-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88106-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88107-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88108-bb-j.bin && \
    rm -f system/quests/challenge-ep1/c88109-bb-j.bin && \
    rm -f system/quests/challenge-ep2/d88201-bb-j.bin && \
    rm -f system/quests/challenge-ep2/d88202-bb-j.bin && \
    rm -f system/quests/challenge-ep2/d88203-bb-j.bin && \
    rm -f system/quests/challenge-ep2/d88204-bb-j.bin && \
    rm -f system/quests/challenge-ep2/d88205-bb-j.bin && \
    rm -f system/quests/events/q073-bb-j.bin && \
    rm -f system/quests/events/q125-bb-j.bin && \
    rm -f system/quests/events/q127-bb-j.bin && \
    rm -f system/quests/events/q144-bb-j.bin && \
    rm -f system/quests/events/q145-bb-j.bin && \
    rm -f system/quests/events/q146-bb-j.bin && \
    rm -f system/quests/events/q207-bb-j.bin && \
    rm -f system/quests/events/q220-bb-j.bin && \
    rm -f system/quests/events/q240-bb-j.bin && \
    rm -f system/quests/events/q241-bb-j.bin && \
    rm -f system/quests/events/q242-bb-j.bin && \
    rm -f system/quests/events/q243-bb-j.bin && \
    rm -f system/quests/events/q248-bb-j.bin && \
    rm -f system/quests/events/q303-bb-j.bin && \
    rm -f system/quests/events/q304-bb-j.bin && \
    rm -f system/quests/events/q305-bb-j.bin && \
    rm -f system/quests/events/q312-bb-j.bin && \
    rm -f system/quests/extermination/q816-bb-j.bin && \
    rm -f system/quests/extermination/q817-bb-j.bin && \
    rm -f system/quests/extermination/q818-bb-j.bin && \
    rm -f system/quests/extermination/q819-bb-j.bin && \
    rm -f system/quests/extermination/q820-bb-j.bin && \
    rm -f system/quests/retrieval/q119-bb-j.bin && \
    rm -f system/quests/retrieval/q120-bb-j.bin && \
    rm -f system/quests/shops/q205-bb-j.bin && \
    rm -f system/quests/solo-extra/q035-bb-j.bin && \
    rm -f system/quests/solo-extra/q126-bb-j.bin && \
    rm -f system/quests/solo-extra/q143-bb-j.bin && \
    rm -f system/quests/solo-story/q001-bb-j.bin && \
    rm -f system/quests/solo-story/q002-bb-j.bin && \
    rm -f system/quests/solo-story/q003-bb-j.bin && \
    rm -f system/quests/solo-story/q004-bb-j.bin && \
    rm -f system/quests/solo-story/q005-bb-j.bin && \
    rm -f system/quests/solo-story/q006-bb-j.bin && \
    rm -f system/quests/solo-story/q007-bb-j.bin && \
    rm -f system/quests/solo-story/q008-bb-j.bin && \
    rm -f system/quests/solo-story/q009-bb-j.bin && \
    rm -f system/quests/solo-story/q010-bb-j.bin && \
    rm -f system/quests/solo-story/q011-bb-j.bin && \
    rm -f system/quests/solo-story/q012-bb-j.bin && \
    rm -f system/quests/solo-story/q013-bb-j.bin && \
    rm -f system/quests/solo-story/q014-bb-j.bin && \
    rm -f system/quests/solo-story/q015-bb-j.bin && \
    rm -f system/quests/solo-story/q016-bb-j.bin && \
    rm -f system/quests/solo-story/q017-bb-j.bin && \
    rm -f system/quests/solo-story/q018-bb-j.bin && \
    rm -f system/quests/solo-story/q019-bb-j.bin && \
    rm -f system/quests/solo-story/q020-bb-j.bin && \
    rm -f system/quests/solo-story/q021-bb-j.bin && \
    rm -f system/quests/solo-story/q022-bb-j.bin && \
    rm -f system/quests/solo-story/q023-bb-j.bin && \
    rm -f system/quests/solo-story/q024-bb-j.bin && \
    rm -f system/quests/solo-story/q025-bb-j.bin && \
    rm -f system/quests/solo-story/q026-bb-j.bin && \
    rm -f system/quests/solo-story/q027-bb-j.bin && \
    rm -f system/quests/solo-story/q030-bb-j.bin && \
    rm -f system/quests/solo-story/q031-bb-j.bin && \
    rm -f system/quests/solo-story/q032-bb-j.bin && \
    rm -f system/quests/solo-story/q033-bb-j.bin && \
    rm -f system/quests/solo-story/q034-bb-j.bin && \
    rm -f system/quests/team/q710-bb-j.bin && \
    rm -f system/quests/vr/q142-bb-j.bin && \
    rm -f system/quests/vr/q231-bb-j.bin && \
    rm -f system/quests/vr/q237-bb-j.bin && \
    rm -f system/quests/vr/q238-bb-j.bin && \
    rm -f system/quests/vr/q313-bb-j.bin && \
    rm -f system/quests/vr/q314-bb-j.bin

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
