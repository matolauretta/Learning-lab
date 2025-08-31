package main

import (
	"fmt"
	"net/http"
	"os"
)

func handler(w http.ResponseWriter, r *http.Request) {
	message := os.Getenv("HELLO_MESSAGE")
	if message == "" {
		message = "Hello from Go in Docker!"
	}
	fmt.Fprintln(w, message)
}

func main() {
	http.HandleFunc("/", handler)
	port := "8080"
	fmt.Println("Starting server on port", port)
	http.ListenAndServe(":"+port, nil)
}
