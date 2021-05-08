FROM golang:1.16 as builder

WORKDIR /workspace
COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -o bin/server cmd/server/server.go

FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /workspace/bin/server .
USER 65532:65532

ENTRYPOINT ["/server"]