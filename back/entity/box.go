package entity

type BoxId int64

type Code []byte

type Box struct {
	Id   BoxId
	Code string
}

type Boxes []Box
