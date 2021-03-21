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
	boxes := &entity.Boxes{}
	if err := b.db.Where("created_by = ?", userId).Find(boxes).Error; err != nil {
		return nil, err
	}
	return boxes, nil
}

func (b *Box) FindCodeById(id entity.BoxId) (entity.Code, error) {
	box := &entity.Box{}
	if err := b.db.Select("code").Where("id = ?", id).Find(box).Error; err != nil {
		return "", err
	}
	return box.Code, nil
}

func (b *Box) Store(e *entity.Box) (*entity.Box, error) {
	if err := b.db.Create(&e).First(&e).Error; err != nil {
		return nil, err
	}
	return e, nil
}

func (b *Box) Update(e *entity.Box) (*entity.Box, error) {
	if err := b.db.Model(&entity.Box{}).Where("id = ?", e.ID).Updates(e).First(e).Error; err != nil {
		return nil, err
	}
	return e, nil
}

func (b *Box) DeleteById(id entity.BoxId) error {
	if err := b.db.Where("id = ?", id).Delete(&entity.Box{}).Error; err != nil {
		return err
	}
	return nil
}
