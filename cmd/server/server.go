package main

import (
	"io"
	"net/http"

	"github.com/coreos/go-systemd/activation"
)

// TODO: signal handling

func HelloServer(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	_, err := io.WriteString(w, "OK\n")
	if err != nil {
		panic(err)
	}
}

func main() {
	listeners, err := activation.Listeners()
	if err != nil {
		panic(err)
	}

	if len(listeners) != 1 {
		panic("Unexpected number of socket activation fds")
	}

	http.HandleFunc("/", HelloServer)
	panic(http.Serve(listeners[0], nil))
}
