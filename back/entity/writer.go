package entity

type Writer struct {
    UserID string `gorm:"primary_key"`
    BoxID BoxId `gorm:"primary_key"`
    Box Box `gorm:"constraint:OnUpdate:CASCADE,OnDelete:CASCADE;"`
}
