FROM docker.io/golang:alpine as build

WORKDIR /build
ENV GOARCH=amd64

COPY go.mod /build/
COPY go.sum /build/
COPY cmd /build/cmd

RUN ["go", "build", "-o", "dist/basic_webserver", "./cmd/basic_webserver/main.go"]

FROM quay.io/fedora/fedora-minimal:latest

WORKDIR /web

COPY --from=build /build/dist/basic_webserver /web/
EXPOSE 8080

CMD ["./basic_webserver"]
