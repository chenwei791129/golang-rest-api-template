FROM golang:1.23.9-alpine3.21
WORKDIR /app

COPY . .
RUN go mod download
RUN go install github.com/swaggo/swag/cmd/swag@latest
RUN swag init -g ./cmd/server/main.go -o ./docs
RUN CGO_ENABLED=0 go build -o bin/server cmd/server/main.go

ENTRYPOINT [ "./bin/server" ]
