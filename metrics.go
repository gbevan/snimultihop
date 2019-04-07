package main

import (
	"net/http"

	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func metrics(listen *string) {
	http.Handle("/metrics", promhttp.Handler())
	http.ListenAndServe(*listen, nil)
}
