##############################################
# Build:
#   docker build -t snimultihop .
#
# Run:
#   docker run --name snimultihop -p 8443:8443 \
#     -v /srv/snimultihop:/app/config \
#     snimultihop
#


##############################################
# Build stage
FROM golang:latest as builder
WORKDIR /go/src/github.com/gbevan/snimultihop

COPY *.go Gopkg* ./
COPY logmsg ./logmsg/

RUN \
  go get github.com/golang/dep/cmd/dep && \
  dep ensure -v --vendor-only && \
  CGO_ENABLED=0 GOOS=linux \
    go build -a \
      -installsuffix cgo \
      -ldflags '-extldflags "-static"' \
      -o snimultihop .


##############################################
# Exe stage
FROM alpine
# FROM alpine:3.3

COPY --from=builder /go/src/github.com/gbevan/snimultihop/snimultihop /usr/bin

WORKDIR /app
COPY start-image.sh .
COPY example.conf ./config/snimultihop.conf

RUN \
  adduser -S -D -H -h /app snimultihop

USER snimultihop
ENTRYPOINT ["/app/start-image.sh"]
