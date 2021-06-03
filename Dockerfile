# custom build
FROM golang:1.16-alpine

ENV VERSION "1.0.2"

RUN apk add --no-cache curl &&\
	curl -L -o /tmp/twitchcli-src.zip https://github.com/twitchdev/twitch-cli/archive/refs/tags/${VERSION}.zip &&\
	unzip /tmp/twitchcli-src.zip -d /tmp/twitchcli-src &&\
	cd /tmp/twitchcli-src/twitch-cli-${VERSION} &&\
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/twitch -ldflags "-s -w -X main.buildVersion=${VERSION}" .

# Base
FROM alpine:3.13

# Installation
COPY --from=0 /usr/local/bin/twitch /usr/local/bin/twitch
