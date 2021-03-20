package entity

import(
	"time"
)

type BoxId int64

type Code string

type Box struct {
	ID   BoxId `gorm:"primary_key"`
	Name string `sql:"index"`
	Note string
	Icon Icon
	Code Code
	CreatedBy string
	CreatedAt time.Time
	UpdatedBy string
	UpdatedAt time.Time
}

type Boxes []Box
