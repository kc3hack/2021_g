package config

import (
	"fmt"
	"os"
)

func IsLocal() bool {
	return os.Getenv("ENV") == "local"
}

func IsDev() bool {
	return os.Getenv("ENV") == "dev"
}

func Port() string {
	return os.Getenv("PORT")
}

func DSN() string {
	return fmt.Sprintf(
		"%s:%s@tcp(%s:%s)/%s",
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_HOST"),
		os.Getenv("DB_PORT"),
		os.Getenv("DB_NAME"),
	) + "?parseTime=true&collation=utf8mb4_bin"
}

func AppLink() string {
	return "http://smart_box.com"
}
