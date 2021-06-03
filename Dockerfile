# Base
FROM alpine:3.13

# env
ENV VERSION "1.0.2"

# Installation
RUN apk add --no-cache curl go &&\
	curl -L -o /tmp/twitchcli-src.zip https://github.com/twitchdev/twitch-cli/archive/refs/tags/${VERSION}.zip &&\
	unzip /tmp/twitchcli-src.zip -d /tmp/twitchcli-src &&\
	cd /tmp/twitchcli-src/twitch-cli-${VERSION} &&\
	env CGO_ENABLED=false GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/twitch -ldflags "-s -w -X main.buildVersion=${VERSION}" .
