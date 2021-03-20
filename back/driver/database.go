package driver

import (
	"log"
	"os"
	"time"

	"github.com/kc3hack/2021_g/config"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var count = 0

func connect(logger logger.Interface) (*gorm.DB, error) {
	db, err := gorm.Open(mysql.Open(config.DSN()), &gorm.Config{
		Logger: logger,
	})
	if err != nil {
		log.Println("Not ready. Retry connecting...")
		time.Sleep(time.Second)
		count++
		log.Println(count)
		if count > 30 {
			panic(err)
		}
		return connect(logger)
	}
	log.Println("Successfully")
	return db, nil
}

func NewDBConn() *gorm.DB {
	newLogger := logger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags), // io writer
		logger.Config{
			SlowThreshold: time.Second,  // Slow SQL threshold
			LogLevel:      logger.Error, // Log level
			Colorful:      false,        // Disable color
		},
	)
	dbConn, err := connect(newLogger)
	if err != nil {
		panic("failed to connect database")
	}

	sqlDB, _ := dbConn.DB()
	sqlDB.SetMaxIdleConns(100)
	sqlDB.SetMaxOpenConns(100)

	if err := sqlDB.Ping(); err != nil {
		panic("failed to ping")
	}

	return dbConn
}
