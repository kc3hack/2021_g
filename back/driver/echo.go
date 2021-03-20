package driver

import (
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/kc3hack/2021_g/openapi"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func bodyDumpHandler(c echo.Context, reqBody, resBody []byte) {
	fmt.Printf("Request Body: %v\n", string(reqBody))
	fmt.Printf("Response Body: %v\n", string(resBody))
}

type handler struct {
}

// box一覧取得
// (GET /boxes)
func (h handler) GetBoxes(ctx echo.Context) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

// box作成
// (POST /boxes)
func (h handler) PostBoxes(ctx echo.Context) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

// 特定のbox削除
// (DELETE /boxes/{box_id})
func (h handler) DeleteBoxesBoxId(ctx echo.Context, boxId openapi.Id) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

// 特定のbox編集
// (PUT /boxes/{box_id})
func (h handler) PutBoxesBoxId(ctx echo.Context, boxId openapi.Id) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

// 特定のboxのitem一覧取得
// (GET /boxes/{box_id}/items)
func (h handler) GetBoxesBoxIdItems(ctx echo.Context, boxId openapi.Id) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

// 特定のboxにitem追加
// (POST /boxes/{box_id}/items)
func (h handler) PostBoxesBoxIdItems(ctx echo.Context, boxId openapi.Id) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

// 特定のboxのQR取得
// (GET /boxes/{box_id}/qr)
func (h handler) GetBoxesBoxIdQr(ctx echo.Context, boxId openapi.Id, params openapi.GetBoxesBoxIdQrParams) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

// 特定のitem削除
// (DELETE /items/{item_id})
func (h handler) DeleteItemsItemId(ctx echo.Context, itemId openapi.Id) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

// 特定のitem編集
// (PUT /items/{item_id})
func (h handler) PutItemsItemId(ctx echo.Context, itemId openapi.Id) error {
	return echo.NewHTTPError(http.StatusInternalServerError, "not implemented")
}

func NewEchoServer() *echo.Echo {
	// conn, err := newDBConn()
	// if err != nil {
	// 	panic(err)
	// }

	e := echo.New()
	e.Use(middleware.Logger())
	now := time.Now().UTC().In(time.FixedZone("Asia/Tokyo", 9*60*60)).Format("20060102150405")
	file, err := os.OpenFile("./log/"+now+".log", os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0644)
	if err != nil {
		panic(err)
	}
	e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
		Output: file,
	}))
	e.Use(middleware.Recover())
	e.Use(middleware.BodyDump(bodyDumpHandler))

	h := handler{}
	// 定義した struct を登録
	openapi.RegisterHandlers(e, h)
	return e
}
