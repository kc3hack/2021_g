package usecase

import (
	"github.com/kc3hack/2021_g/entity"
	"github.com/kc3hack/2021_g/framework"
)

type boxRepository interface {
	FindALLByUserId(userId entity.UserId) (*entity.Boxes, error)
	FindCodeById(id entity.BoxId) (entity.Code, error)
	Store(e *entity.Box) (*entity.Box, error)
	Update(e *entity.Box) (*entity.Box, error)
	DeleteById(id entity.BoxId) error
}

type Box struct {
	boxRepo boxRepository
}

func NewBox(boxRepo boxRepository) *Box {
	return &Box{
		boxRepo: boxRepo,
	}
}

func (b *Box) GetBoxes(userId entity.UserId) (*entity.Boxes, error) {
	boxes, err := b.boxRepo.FindALLByUserId(userId)
	if err != nil {
		return nil, err
	}

	return boxes, err
}

func (b *Box) GetBoxesBoxIdQr(id entity.BoxId) (string, error) {
	base64Qr, err := b.boxRepo.FindCodeById(id)
	if err != nil {
		return "", err
	}
	return string(base64Qr), nil
}

func (b *Box) PostBoxes(box *entity.Box) (*entity.Box, error) {
	box, err := b.boxRepo.Store(box)
	if err != nil {
		return nil, err
	}
	filePath := framework.NewQRImg(box.ID)
	base64Qr := framework.ImageBase64Encode(filePath)
	box.Code = entity.Code(base64Qr)
	box, err = b.boxRepo.Update(box)
	if err != nil {
		return nil, err
	}
	return box, nil
}

func (b *Box) PutBoxesBoxId(box *entity.Box) (*entity.Box, error) {
	box, err := b.boxRepo.Update(box)
	if err != nil {
		return nil, err
	}
	return box, nil
}

func (b *Box) DeleteBoxesBoxId(id entity.BoxId) error {
	if err := b.boxRepo.DeleteById(id); err != nil {
		return err
	}
	return nil
}
