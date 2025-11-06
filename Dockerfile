# Given build
# I'm not going to make you all fight with compiling go
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o server .

# Step 2: Run
FROM alpine:3.20
# Set working directory
WORKDIR /app

# Copy the built server from the builder stage
COPY --from=builder /app/server /app/server

# Expose port 8080
EXPOSE 8080

# Run the server
CMD ["./server"]

