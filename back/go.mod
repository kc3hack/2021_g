module github.com/kc3hack/2021_g

go 1.16

require (
	github.com/deepmap/oapi-codegen v1.5.3
	github.com/labstack/echo/v4 v4.2.1
)

replace gopkg.in/urfave/cli.v2 => github.com/urfave/cli/v2 v2.2.0 // Need to use github.com/oxequa/realize, used in ./Dockerfile
