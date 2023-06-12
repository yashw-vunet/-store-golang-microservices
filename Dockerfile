FROM golang:1.17-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Use the 'find' command to locate the Go file(s)
RUN go_files=$(find . -type f -name '*.go') && \
    if [ -n "$go_files" ]; then \
        echo "Go file(s) found: $go_files"; \
        go build -o myapp .; \
    else \
        echo "No Go file(s) found."; \
    fi

FROM alpine:3.14

WORKDIR /app

COPY --from=builder /app/myapp .

EXPOSE 8080

CMD ["./myapp"]
