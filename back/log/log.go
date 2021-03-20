package log

import (
	"github.com/kc3hack/2021_g/config"
	"github.com/labstack/gommon/log"
)

func New() *log.Logger {
	logger := log.New("application")
	logger.SetLevel(log.INFO)
	if config.IsLocal() || config.IsDev() {
		logger.SetLevel(log.DEBUG)
	}
	return logger
}
