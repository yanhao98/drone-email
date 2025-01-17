FROM golang:1.17-alpine as builder

WORKDIR /go/src/drone-email
COPY . .

RUN GOOS=linux CGO_ENABLED=0 go build

FROM alpine:3.14

RUN apk add --no-cache ca-certificates tzdata

COPY --from=builder /go/src/drone-email/drone-email /bin/
ENTRYPOINT ["/bin/drone-email"]
