package handler

import (
	"net/http"

	"github.com/kc3hack/2021_g/driver"
	"github.com/kc3hack/2021_g/entity"
	"github.com/kc3hack/2021_g/framework"
	"github.com/kc3hack/2021_g/log"
	"github.com/kc3hack/2021_g/openapi"
	"github.com/labstack/echo/v4"
)

// box一覧取得
// (GET /boxes)
func (h Handler) GetBoxes(ctx echo.Context) error {
	logger := log.New()

	cctx, ok := ctx.(*driver.CostomContext)

	if !ok {
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	userId := cctx.UserId
	boxes, err := h.BoxUC.GetBoxes(entity.UserId(userId))
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := []openapi.Box{}
	for _, box := range *boxes {
		res = append(res, openapi.Box{
			CreatedAt: openapi.Datetime(box.CreatedAt),
			CreatedBy: openapi.User{
				Name: box.CreatedBy,
			},
			Icon:      openapi.Base64(box.Icon),
			Id:        openapi.Id(box.ID),
			Name:      openapi.BoxName(box.Name),
			Note:      openapi.Note(box.Note),
			UpdatedAt: openapi.Datetime(box.UpdatedAt),
			UpdatedBy: openapi.User{
				Name: box.UpdatedBy,
			},
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
		Name: string(req.Name),
		Note: string(*req.Note),
		Icon: entity.Icon(*req.Icon),
	}

	resBox, err := h.BoxUC.PostBoxes(reqBox)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	filePath := framework.NewQRImg(resBox.ID)
	qrBase64 := framework.ImageBase64Encode(filePath)
	resBox.Code = entity.Code(qrBase64)
	resBox, err = h.BoxUC.PutBoxesBoxId(resBox)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Box{
		CreatedAt: openapi.Datetime(resBox.CreatedAt),
		CreatedBy: openapi.User{
			Name: resBox.CreatedBy,
		},
		Icon:      openapi.Base64(resBox.Icon),
		Id:        openapi.Id(resBox.ID),
		Name:      openapi.BoxName(resBox.Name),
		Note:      openapi.Note(resBox.Note),
		UpdatedAt: openapi.Datetime(resBox.UpdatedAt),
		UpdatedBy: openapi.User{
			Name: resBox.UpdatedBy,
		},
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
		ID:   entity.BoxId(boxId),
		Name: string(*req.Name),
		Icon: entity.Icon(*req.Icon),
		Note: string(*req.Note),
	}

	resBox, err := h.BoxUC.PostBoxes(reqBox)
	if err != nil {
		logger.Error(err)
		return echo.NewHTTPError(http.StatusInternalServerError)
	}

	res := openapi.Box{
		CreatedAt: openapi.Datetime(resBox.CreatedAt),
		CreatedBy: openapi.User{
			Name: resBox.CreatedBy,
		},
		Icon:      openapi.Base64(resBox.Icon),
		Id:        openapi.Id(resBox.ID),
		Name:      openapi.BoxName(resBox.Name),
		Note:      openapi.Note(resBox.Note),
		UpdatedAt: openapi.Datetime(resBox.UpdatedAt),
		UpdatedBy: openapi.User{
			Name: resBox.UpdatedBy,
		},
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
