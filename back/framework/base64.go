package framework

import (
	"encoding/base64"
	"os"
)

func ImageBase64Encode(filePath string) string {
	file, _ := os.Open(filePath)
	defer file.Close()

	fi, _ := file.Stat()
	size := fi.Size()

	data := make([]byte, size)
	_, _ = file.Read(data)

	b64Enc := base64.StdEncoding.EncodeToString(data)

	os.Remove(filePath)

	return b64Enc
}
