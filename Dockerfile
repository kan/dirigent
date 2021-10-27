FROM golang:1.17.2 as develop

WORKDIR /app
COPY . /app
COPY ./sshd/id_ed25519 /root/.ssh/id_ed25519
RUN chmod 600 /root/.ssh/id_ed25519

RUN go build
VOLUME ["/go/pkg/mod"]

RUN go get -u github.com/cosmtrek/air

CMD air

FROM golang:1.17.2 as builder

WORKDIR /app
COPY . /app

RUN CGO_ENABLED=0 go build

FROM scratch

COPY --from=golang:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=golang:latest /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /app/api /app

CMD ["/app"]
