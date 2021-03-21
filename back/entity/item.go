package entity

import(
	"time"
)

type ItemId int64

type Item struct {
	ID ItemId `gorm:"primary_key"`
	BoxID BoxId
	Box Box `gorm:"constraint:OnUpdate:CASCADE,OnDelete:CASCADE;"`
	Name string
	Note string
	Icon Icon
	CreatedBy string
	CreatedAt time.Time
	UpdatedBy string
	UpdatedAt time.Time
}

type Items []Item
