package config

import "os"

func IsLocal() bool {
	return os.Getenv("ENV") == "local"
}

func IsDev() bool {
	return os.Getenv("ENV") == "dev"
}

func Port() string {
	return os.Getenv("PORT")
}
