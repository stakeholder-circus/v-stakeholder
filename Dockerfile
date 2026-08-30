FROM alpine:3.24 AS build

ARG V_COMMIT=7647ce1c6fad63b5578bc07883139906de74b2f8
RUN apk add --no-cache build-base git
RUN git clone --filter=blob:none https://github.com/vlang/v.git /opt/v \
    && git -C /opt/v checkout --detach "$V_COMMIT" \
    && make -C /opt/v

WORKDIR /src
COPY src/main.v src/main.v
COPY tests/test_cli.sh tests/test_cli.sh
RUN /opt/v/v fmt -verify src/main.v \
    && mkdir -p /out \
    && /opt/v/v -prod -gc none -o /out/stakeholder src/main.v \
    && BIN=/out/stakeholder tests/test_cli.sh

FROM alpine:3.24
RUN addgroup -S stakeholder && adduser -S -G stakeholder stakeholder
COPY --from=build /out/stakeholder /usr/local/bin/v-stakeholder
USER stakeholder
ENTRYPOINT ["/usr/local/bin/v-stakeholder"]
CMD ["--list-values"]
