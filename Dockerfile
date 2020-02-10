FROM golang as builder

WORKDIR /src
COPY . .

RUN go build -o /bin/<<PROJECT>> cmd/<<PROJECT>>/main.go

FROM gcr.io/distroless/base
COPY --from=builder /bin/<<PROJECT>> /bin/<<PROJECT>>

ENTRYPOINT ["/bin/<<PROJECT>>"]
