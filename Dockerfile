FROM golang:1.21-alpine AS build
WORKDIR /app
COPY . .
RUN go mod init proxy && go mod tidy
RUN go build -ldflags="-s -w" -o proxy

FROM alpine:3.20
COPY --from=build /app/proxy /proxy
EXPOSE 8080
ENTRYPOINT ["/proxy"]
