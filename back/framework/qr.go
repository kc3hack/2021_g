package framework

import (
	"fmt"
	"image"
	"image/color"
	"os"
	"strconv"

	"github.com/kc3hack/2021_g/config"
	"github.com/kc3hack/2021_g/entity"
	"github.com/nfnt/resize"
	qrcode "github.com/yeqown/go-qrcode"
)

func NewQRImg(boxId entity.BoxId) string {
	file, _ := os.Open("material/icon.png")
	img, _, _ := image.Decode(file)
	m := resize.Resize(80, 0, img, resize.Lanczos3)

	qrc, err := qrcode.New(config.AppLink()+"/box/"+strconv.FormatInt(int64(boxId), 10), qrcode.WithQRWidth(10), qrcode.WithFgColor(color.RGBA{122, 208, 206, 255}), qrcode.WithLogoImage(m))
	if err != nil {
		fmt.Printf("could not generate QRCode: %v", err)
	}

	// save file
	filePath := "tmp/" + strconv.FormatInt(int64(boxId), 10) + ".png"
	if err := qrc.Save(filePath); err != nil {
		fmt.Printf("could not save image: %v", err)
	}
	return filePath
}
