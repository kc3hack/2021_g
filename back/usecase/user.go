package usecase

type userRepository interface {
}

type User struct {
	userRepo userRepository
}

func NewUser(userRepo userRepository) *User {
	return &User{
		userRepo: userRepo,
	}
}
