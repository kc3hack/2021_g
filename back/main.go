package main

import (
	"fmt"

	"github.com/labstack/echo/v4"

	"github.com/kc3hack/2021_g/config"
	"github.com/kc3hack/2021_g/driver"
	"github.com/kc3hack/2021_g/handler"
	"github.com/kc3hack/2021_g/openapi"
	"github.com/kc3hack/2021_g/repository"
	"github.com/kc3hack/2021_g/usecase"
)

func main() {
	// fmt.Print("Hello world")

	db := driver.NewDBConn()

	e := driver.NewEchoServer()

	boxRepo := repository.NewBox(db)
	itemRepo := repository.NewItem(db)
	userRepo := repository.NewUser(db)
	boxUC := usecase.NewBox(boxRepo)
	itemUC := usecase.NewItem(itemRepo)
	userUC := usecase.NewUser(userRepo)
	h := handler.NewHandler(boxUC, itemUC, userUC)
	openapi.RegisterHandlers(e, h)
	e.Logger.Fatal(e.Start(fmt.Sprintf("0.0.0.0:%s", config.Port())))
}
