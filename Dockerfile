FROM golang:1.19-buster AS build
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /example-web-service-gin

FROM gcr.io/distroless/base-debian10
WORKDIR /
COPY --from=build /example-web-service-gin /example-web-service-gin
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/example-web-service-gin"]
