bin/server: cmd/server/server.go
	go build -o bin/server ./cmd/server/

.PHONY: vet
vet:
	shellcheck ./hack/*