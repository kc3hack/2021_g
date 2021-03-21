package repository

import (
	"github.com/kc3hack/2021_g/entity"
	"gorm.io/gorm"
)

type Box struct {
	db *gorm.DB
}

func NewBox(db *gorm.DB) *Box {
	return &Box{
		db: db,
	}
}

func (b *Box) FindALLByUserId(userId entity.UserId) (*entity.Boxes, error) {
	return &entity.Boxes{}, nil
}

func (b *Box) FindCodeById(id entity.BoxId) (entity.Code, error) {
	return entity.Code(""), nil
}

func (b *Box) Store(e *entity.Box) (*entity.Box, error) {
	return &entity.Box{}, nil
}

func (b *Box) Update(e *entity.Box) (*entity.Box, error) {
	return &entity.Box{}, nil
}

func (b *Box) DeleteById(id entity.BoxId) error {
	return nil
}
