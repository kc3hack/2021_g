package handler

import (
	"net/http"

	"github.com/kc3hack/2021_g/entity"
	"github.com/kc3hack/2021_g/log"
	"github.com/kc3hack/2021_g/openapi"
	"github.com/labstack/echo/v4"
)

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
	for _, item := range *items {
		res = append(res, openapi.Item{
			CreatedAt: openapi.Datetime(item.CreatedAt),
			CreatedBy: openapi.User{
				Name: item.CreatedBy,
			},
			Icon:      openapi.Base64(item.Icon),
			Id:        openapi.Id(item.ID),
			Name:      openapi.ItemName(item.Name),
			Note:      openapi.Note(item.Note),
			UpdatedAt: openapi.Datetime(item.UpdatedAt),
			UpdatedBy: openapi.User{
				Name: item.UpdatedBy,
			},
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

	reqItem := &entity.Item{
		BoxID: entity.BoxId(boxId),
		Name:  string(req.Name),
	}
	if req.Note != nil {
		reqItem.Note = string(*req.Note)
	}
	if req.Icon != nil {
		reqItem.Icon = entity.Icon(*req.Icon)
	}

	resItem, err := h.ItemUC.PostBoxesBoxIdItems(reqItem)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Item{
		CreatedAt: openapi.Datetime(resItem.CreatedAt),
		CreatedBy: openapi.User{
			Name: resItem.CreatedBy,
		},
		Icon:      openapi.Base64(resItem.Icon),
		Id:        openapi.Id(resItem.ID),
		Name:      openapi.ItemName(resItem.Name),
		Note:      openapi.Note(resItem.Note),
		UpdatedAt: openapi.Datetime(resItem.UpdatedAt),
		UpdatedBy: openapi.User{
			Name: resItem.UpdatedBy,
		},
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

	reqItem := &entity.Item{
		ID: entity.ItemId(itemId),
	}
	if req.Name != nil {
		reqItem.Name = string(*req.Name)
	}
	if req.Note != nil {
		reqItem.Note = string(*req.Note)
	}
	if req.Icon != nil {
		reqItem.Icon = entity.Icon(*req.Icon)
	}

	resItem, err := h.ItemUC.PutItemsItemId(reqItem)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Item{
		CreatedAt: openapi.Datetime(resItem.CreatedAt),
		CreatedBy: openapi.User{
			Name: resItem.CreatedBy,
		},
		Icon:      openapi.Base64(resItem.Icon),
		Id:        openapi.Id(resItem.ID),
		Name:      openapi.ItemName(resItem.Name),
		Note:      openapi.Note(resItem.Note),
		UpdatedAt: openapi.Datetime(resItem.UpdatedAt),
		UpdatedBy: openapi.User{
			Name: resItem.UpdatedBy,
		},
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
