package usecase

import (
	"github.com/kc3hack/2021_g/entity"
)

type itemRepository interface {
	FindALLByBoxId(boxId entity.BoxId) (*entity.Items, error)
	Store(e *entity.Item) (*entity.Item, error)
	Update(e *entity.Item) (*entity.Item, error)
	DeleteById(id entity.ItemId) error
}

type Item struct {
	itemRepo itemRepository
}

func NewItem(itemRepo itemRepository) *Item {
	return &Item{
		itemRepo: itemRepo,
	}
}

func (i *Item) GetBoxesBoxIdItems(boxId entity.BoxId) (*entity.Items, error) {
	items, err := i.itemRepo.FindALLByBoxId(boxId)
	if err != nil {
		return nil, err
	}
	return items, err
}

func (i *Item) PostBoxesBoxIdItems(e *entity.Item) (*entity.Item, error) {
	item, err := i.itemRepo.Store(e)
	if err != nil {
		return nil, err
	}
	return item, err
}

func (i *Item) PutItemsItemId(e *entity.Item) (*entity.Item, error) {
	item, err := i.itemRepo.Update(e)
	if err != nil {
		return nil, err
	}
	return item, err
}

func (i *Item) DeleteItemsItemId(id entity.ItemId) error {
	if err := i.itemRepo.DeleteById(id); err != nil {
		return err
	}
	return nil
}
