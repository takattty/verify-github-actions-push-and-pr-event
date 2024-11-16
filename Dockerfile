FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app -ldflags="-w -s" ./main.go

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/app .
CMD ["./app"]