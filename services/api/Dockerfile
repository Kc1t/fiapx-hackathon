FROM golang:1.24-alpine AS build
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -o /out/app .

FROM alpine:3.20

RUN adduser -D -u 10001 app
COPY --from=build /out/app /app
USER app
EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=3s CMD wget -qO- http://localhost:8080/healthz || exit 1
ENTRYPOINT ["/app"]
