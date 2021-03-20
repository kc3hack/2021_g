package main

import (
	"fmt"

	"github.com/kc3hack/2021_g/config"
	"github.com/kc3hack/2021_g/driver"
)

func main() {
	// fmt.Print("Hello world")

	e := driver.NewEchoServer()
	e.Logger.Fatal(e.Start(fmt.Sprintf("0.0.0.0:%s", config.Port())))
}
