# build executable binary
FROM golang:1.18 AS builder

WORKDIR /app

COPY . .

RUN go get -d -v ./...
RUN go install -v ./...
RUN GOOS=linux GOARCH=amd64 go build -o go-exe .

# build image
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/go-exe ./go-exe
EXPOSE 8000
CMD ["./go-exe"]