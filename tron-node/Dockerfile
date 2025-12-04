ARG JAVA_TRON_VERSION=latest

FROM azul/zulu-openjdk:8u472 AS build-plugin

WORKDIR /src
RUN apt-get update && \
    apt-get install -y --no-install-recommends git ca-certificates && \
    rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 https://github.com/tronprotocol/event-plugin.git

RUN cd event-plugin && \
    ./gradlew build -x test

FROM tronprotocol/java-tron:${JAVA_TRON_VERSION}

COPY --from=build-plugin /src/event-plugin/build/plugins/ /usr/local/tron/plugins/
COPY ./configs/ /etc/tron/

COPY ./entry.sh /usr/bin/entry.sh

ENTRYPOINT [ "entry.sh" ]
