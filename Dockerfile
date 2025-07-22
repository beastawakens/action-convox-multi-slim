FROM ubuntu:22.04

LABEL version="v1.0.32"
LABEL repository="https://github.com/beastawakens/action-convox-multi-slim"
LABEL homepage="https://convox.com/"
LABEL maintainer="Beast Awakens <me@beastawakens.com>"

LABEL "com.github.actions.name"="Convox"
LABEL "com.github.actions.description"="Perform multiple convox commands"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="blue"

RUN apt-get -qq update && apt-get -qq -y install curl

RUN curl -L https://github.com/convox/convox/releases/latest/download/convox-linux -o /tmp/convox \
    && mv /tmp/convox /usr/local/bin/convox \
    && chmod 755 /usr/local/bin/convox

COPY entrypoint* /
ENTRYPOINT ["/entrypoint.sh"]