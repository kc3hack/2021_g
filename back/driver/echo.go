package driver

import (
	"fmt"
	"os"
	"time"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func bodyDumpHandler(c echo.Context, reqBody, resBody []byte) {
	fmt.Printf("Request Body: %v\n", string(reqBody))
	fmt.Printf("Response Body: %v\n", string(resBody))
}

func NewEchoServer() *echo.Echo {
	e := echo.New()
	e.Use(middleware.Logger())
	now := time.Now().UTC().In(time.FixedZone("Asia/Tokyo", 9*60*60)).Format("20060102150405")
	file, err := os.OpenFile("./logfile/"+now+".log", os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0644)
	if err != nil {
		panic(err)
	}
	e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
		Output: file,
	}))
	e.Use(middleware.Recover())
	e.Use(middleware.CORS())
	e.Use(middleware.BodyDump(bodyDumpHandler))
	return e
}
