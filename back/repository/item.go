package repository

import (
	"github.com/kc3hack/2021_g/entity"
	"gorm.io/gorm"
)

type Item struct {
	db *gorm.DB
}

func NewItem(db *gorm.DB) *Item {
	return &Item{
		db: db,
	}
}

func (i *Item) FindALLByBoxId(boxId entity.BoxId) (*entity.Items, error) {
	return &entity.Items{}, nil
}

func (i *Item) Store(e *entity.Item) (*entity.Item, error) {
	return &entity.Item{}, nil
}

func (i *Item) Update(e *entity.Item) (*entity.Item, error) {
	return &entity.Item{}, nil
}

func (i *Item) DeleteById(id entity.ItemId) error {
	return nil
}
