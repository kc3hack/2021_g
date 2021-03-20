package handler

import (
	"net/http"

	"github.com/kc3hack/2021_g/entity"
	"github.com/kc3hack/2021_g/log"
	"github.com/kc3hack/2021_g/openapi"
	"github.com/kc3hack/2021_g/driver"
	"github.com/labstack/echo/v4"
)

// box一覧取得
// (GET /boxes)
func (h Handler) GetBoxes(ctx echo.Context) error {
	logger := log.New()

	cctx, ok := ctx.(*driver.CostomContext)

	if !ok {
		// TODO
	}

	userId := cctx.UserId //TODO: トークンから取得
	boxes, err := h.BoxUC.GetBoxes(entity.UserId(userId))
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := []openapi.Box{}
	for range *boxes {
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

	reqBox := &entity.Box{
		//TODO
	}

	resBox, err := h.BoxUC.PostBoxes(reqBox)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Box{
		Id: openapi.Id(resBox.ID),
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

	reqBox := &entity.Box{
		//TODO
	}

	resBox, err := h.BoxUC.PostBoxes(reqBox)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Box{
		Id: openapi.Id(resBox.ID),
		// TODO
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
