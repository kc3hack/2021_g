FROM golang:1.16.2-alpine as build

WORKDIR /go/src

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN apk add --no-cache git \
    # && go build -o app \
    && go get github.com/oxequa/realize

CMD ["realize", "start"]

