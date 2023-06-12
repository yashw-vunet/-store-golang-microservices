# Use a Golang base image
FROM golang:1.17-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files
COPY go.mod go.sum ./

# Download and cache Go modules
RUN go mod download

# Copy the application source code to the container
COPY . .

# Build the Go application
RUN go build -o myapp

# Use a minimal Alpine-based image for the final container
FROM alpine:3.14

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled Go application from the builder stage
COPY --from=builder /app/myapp .

# Expose a port if your Go application listens on a specific port
EXPOSE 8080

# Set the command to run your Go application
CMD ["./myapp"]
