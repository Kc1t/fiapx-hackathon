package main

import (
	"log/slog"
	"net/http"
	"os"
)

func newMux() *http.ServeMux {
	mux := http.NewServeMux()
	mux.HandleFunc("GET /healthz", func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusOK)
		_, _ = w.Write([]byte("ok"))
	})
	return mux
}

func getenv(key, def string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return def
}

func main() {
	log := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	addr := ":" + getenv("PORT", "8080")
	log.Info("starting", "service", "api", "addr", addr)
	if err := http.ListenAndServe(addr, newMux()); err != nil {
		log.Error("server stopped", "err", err)
		os.Exit(1)
	}
}
