module github.com/kc3hack/2021_g

go 1.16

require (
	github.com/deepmap/oapi-codegen v1.5.3
	github.com/labstack/echo/v4 v4.2.1
	github.com/labstack/gommon v0.3.0
	github.com/rubenv/sql-migrate v0.0.0-20210215143335-f84234893558 // indirect
	gorm.io/driver/mysql v1.0.5
	gorm.io/gorm v1.21.4
)

replace gopkg.in/urfave/cli.v2 => github.com/urfave/cli/v2 v2.2.0 // Need to use github.com/oxequa/realize, used in ./Dockerfile
