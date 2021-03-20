package handler

import (
	"net/http"

	"github.com/kc3hack/2021_g/entity"
	"github.com/kc3hack/2021_g/log"
	"github.com/kc3hack/2021_g/openapi"
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

// box一覧取得
// (GET /boxes)
func (h Handler) GetBoxes(ctx echo.Context) error {
	logger := log.New()

	userId := "" //TODO: トークンから取得
	boxes, err := h.BoxUC.GetBoxes(entity.UserId(userId))
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := []openapi.Box{}
	for _, _ = range *boxes {
		res = append(res, openapi.Box{
			//TODO
		})
	}
	return ctx.JSON(http.StatusOK, res)
}

// 特定のboxのQR取得
// (GET /boxes/{box_id}/qr)
func (h Handler) GetBoxesBoxIdQr(ctx echo.Context, boxId openapi.Id, params openapi.GetBoxesBoxIdQrParams) error {
	logger := log.New()

	qrBase64, err := h.BoxUC.GetBoxesBoxIdQr(entity.BoxId(boxId))
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Base64(qrBase64)

	return ctx.JSON(http.StatusOK, res)
}

// box作成
// (POST /boxes)
func (h Handler) PostBoxes(ctx echo.Context) error {
	logger := log.New()

	req := &openapi.PostBoxesJSONRequestBody{}
	if err := ctx.Bind(req); err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	box := &entity.Box{
		//TODO
	}

	box, err := h.BoxUC.PostBoxes(box)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Box{
		//TODO
	}

	return ctx.JSON(http.StatusCreated, res)
}

// 特定のbox編集
// (PUT /boxes/{box_id})
func (h Handler) PutBoxesBoxId(ctx echo.Context, boxId openapi.Id) error {
	logger := log.New()

	req := &openapi.PutBoxesBoxIdJSONRequestBody{}
	if err := ctx.Bind(req); err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	box := &entity.Box{
		//TODO
	}

	box, err := h.BoxUC.PostBoxes(box)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Box{
		//TODO
	}

	return ctx.JSON(http.StatusCreated, res)
}

// 特定のbox削除
// (DELETE /boxes/{box_id})
func (h Handler) DeleteBoxesBoxId(ctx echo.Context, boxId openapi.Id) error {
	logger := log.New()

	if err := h.BoxUC.DeleteBoxesBoxId(entity.BoxId(boxId)); err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	return ctx.JSON(http.StatusNoContent, nil)
}

// 特定のboxのitem一覧取得
// (GET /boxes/{box_id}/items)
func (h Handler) GetBoxesBoxIdItems(ctx echo.Context, boxId openapi.Id) error {
	logger := log.New()

	items, err := h.ItemUC.GetBoxesBoxIdItems(entity.BoxId(boxId))
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := []openapi.Item{}
	for _, _ = range *items {
		res = append(res, openapi.Item{
			//TODO
		})
	}
	return ctx.JSON(http.StatusOK, res)
}

// 特定のboxにitem追加
// (POST /boxes/{box_id}/items)
func (h Handler) PostBoxesBoxIdItems(ctx echo.Context, boxId openapi.Id) error {
	logger := log.New()

	req := &openapi.PostBoxesBoxIdItemsJSONRequestBody{}
	if err := ctx.Bind(req); err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	item := &entity.Item{
		//TODO
	}

	item, err := h.ItemUC.PostBoxesBoxIdItems(item)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Item{
		//TODO
	}

	return ctx.JSON(http.StatusCreated, res)
}

// 特定のitem編集
// (PUT /items/{item_id})
func (h Handler) PutItemsItemId(ctx echo.Context, itemId openapi.Id) error {
	logger := log.New()

	req := &openapi.PutItemsItemIdJSONRequestBody{}
	if err := ctx.Bind(req); err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	item := &entity.Item{
		//TODO
	}

	item, err := h.ItemUC.PutItemsItemId(item)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Item{
		//TODO
	}

	return ctx.JSON(http.StatusCreated, res)
}

// 特定のitem削除
// (DELETE /items/{item_id})
func (h Handler) DeleteItemsItemId(ctx echo.Context, itemId openapi.Id) error {
	logger := log.New()

	if err := h.ItemUC.DeleteItemsItemId(entity.ItemId(itemId)); err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	return ctx.JSON(http.StatusNoContent, nil)
}
