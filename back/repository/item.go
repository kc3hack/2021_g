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
	items := &entity.Items{}
	if err := i.db.Where("box_id = ?", boxId).Find(items).Error; err != nil {
		return nil, err
	}
	return items, nil
}

func (i *Item) Store(e *entity.Item) (*entity.Item, error) {
	if err := i.db.Create(e).First(e).Error; err != nil {
		return nil, err
	}
	return e, nil
}

func (i *Item) Update(e *entity.Item) (*entity.Item, error) {
	if err := i.db.Updates(e).First(e).Error; err != nil {
		return nil, err
	}
	return e, nil
}

func (i *Item) DeleteById(id entity.ItemId) error {
	if err := i.db.Where("id = ?", id).Delete(&entity.Item{}).Error; err != nil {
		return err
	}
	return nil
}
