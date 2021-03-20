package handler

import (
	"net/http"

	"github.com/kc3hack/2021_g/usecase"
	"github.com/labstack/echo/v4"
)

type Handler struct {
	BoxUC  *usecase.Box
	ItemUC *usecase.Item
	UserUC *usecase.User
}

func NewHandler(boxUC *usecase.Box, itemUC *usecase.Item, userUC *usecase.User) *Handler {
	return &Handler{
		BoxUC:  boxUC,
		ItemUC: itemUC,
		UserUC: userUC,
	}
}

func (h Handler) Get(ctx echo.Context) error {
	return ctx.JSON(http.StatusOK, "Hello world!")
}
