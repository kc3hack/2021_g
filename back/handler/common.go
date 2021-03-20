package handler

import (
	"github.com/kc3hack/2021_g/usecase"
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
