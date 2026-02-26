FROM ubuntu:22.04

LABEL version="v2.0.0"
LABEL repository="https://github.com/beastawakens/action-convox-multi-slim"
LABEL homepage="https://convox.com/"
LABEL maintainer="Beast Awakens <me@beastawakens.com>"

LABEL "com.github.actions.name"="Convox"
LABEL "com.github.actions.description"="Perform multiple convox commands"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="blue"

# hadolint ignore=DL3008
RUN apt-get -qq update \
    && apt-get -qq -y --no-install-recommends install curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/convox/convox/releases/latest/download/convox-linux -o /tmp/convox \
    && mv /tmp/convox /usr/local/bin/convox \
    && chmod 755 /usr/local/bin/convox

COPY entrypoint* /
COPY lib/ /lib/
ENTRYPOINT ["/entrypoint.sh"]