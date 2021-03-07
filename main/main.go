package main

import (
	"fmt"
	"net/http"
)

func main() {
	serverMuxMetrics := http.NewServeMux()
	serverMuxMetrics.HandleFunc("/metrics", Metrics)
	serverMuxHello := http.NewServeMux()
	serverMuxHello.HandleFunc("/hello", HelloServer)

	go func() {
		http.ListenAndServe(":9100", serverMuxMetrics)
	}()
	http.ListenAndServe(":8080", serverMuxHello)
}

//Metrics will serve metrics for prometheus later on port 9100
func Metrics(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, metrics!")
}

//HelloServer comment
func HelloServer(w http.ResponseWriter, r *http.Request) {
	path := "." + r.URL.Path
	if path == "./hello" {
		path = "./static/index.html"
	}
	http.ServeFile(w, r, path)

}
