FROM debian:bookworm-slim AS build

ARG V_VERSION=0.5.2
ARG V_LINUX_SHA256=86caf9e70c3342d48ef19eb4f6c47b709f18c90ae86255520d5c29df6b482e23

RUN apt-get update \
    && apt-get install --yes --no-install-recommends build-essential ca-certificates curl unzip \
    && rm -rf /var/lib/apt/lists/*
RUN curl --fail --location --silent --show-error \
      "https://github.com/vlang/v/releases/download/${V_VERSION}/v_linux.zip" \
      --output /tmp/v_linux.zip \
    && echo "${V_LINUX_SHA256}  /tmp/v_linux.zip" | sha256sum --check --strict \
    && unzip -q /tmp/v_linux.zip -d /opt \
    && test -x /opt/v/v \
    && ln -s /opt/v/v /usr/local/bin/v \
    && rm /tmp/v_linux.zip

WORKDIR /src
COPY src/main.v src/main.v
COPY tests/test_cli.sh tests/test_cli.sh
RUN v fmt -verify src/main.v \
    && mkdir -p /out \
    && v -prod -gc none -o /out/stakeholder src/main.v \
    && BIN=/out/stakeholder tests/test_cli.sh

FROM debian:bookworm-slim
RUN groupadd --system stakeholder \
    && useradd --system --gid stakeholder --home-dir /nonexistent --shell /usr/sbin/nologin stakeholder
COPY --from=build /out/stakeholder /usr/local/bin/v-stakeholder
USER stakeholder
ENTRYPOINT ["/usr/local/bin/v-stakeholder"]
CMD ["--list-values"]
