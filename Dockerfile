FROM golang:1.17-alpine AS builder

WORKDIR ./services/orders/cmd

COPY go.mod go.sum ./
RUN go mod download

COPY . .

WORKDIR ./services/orders/cmd
# Use the 'find' command to locate the Go file(s)
RUN find . -type f -name '*.go' -exec echo {} \;

RUN go build -o main .

FROM alpine:3.14

WORKDIR ./services/orders/cmd

COPY --from=builder /app/main .

EXPOSE 8080

CMD ["./main"]
