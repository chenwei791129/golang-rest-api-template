FROM golang:1.23.9-alpine3.21

WORKDIR /app

COPY . .
RUN go mod download && \
    go mod verify && \
    go install github.com/swaggo/swag/cmd/swag@latest && \
    swag init -g ./cmd/server/main.go -o ./docs && \
    CGO_ENABLED=0 go build -o bin/server cmd/server/main.go

ENTRYPOINT [ "./bin/server" ]
