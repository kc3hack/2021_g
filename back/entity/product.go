package entity

type Product struct {
    Jan string `gorm:"primary_key"`
    Name string `sql:"index"`
	Icon Icon
}
