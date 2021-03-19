all:
	oapi-codegen -generate "types" -package openapi openapi.yaml > types.gen.go
	oapi-codegen -generate "server" -package openapi openapi.yaml > server.gen.go
	# oapi-codegen -generate "spec" -package openapi openapi.yaml > spec.gen.go
install:
	go get github.com/deepmap/oapi-codegen/cmd/oapi-codegen
clean:
	rm -f *.gen.go
