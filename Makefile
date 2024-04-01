APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=manchy
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
OS ?= #linux darwin windows
ARCH ?= #arm64 amd64

format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

linux: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build -v -o kbot -ldflags "-X="github.com/devops-prometheus-course/03-dockerfile-makefile/cmd.appVersion=${VERSION}

darwin: format get
	CGO_ENABLED=0 GOOS=darwin GOARCH=${ARCH} go build -v -o kbot -ldflags "-X="github.com/devops-prometheus-course/03-dockerfile-makefile/cmd.appVersion=${VERSION}

windows: format get
	CGO_ENABLED=0 GOOS=windows GOARCH=${ARCH} go build -v -o kbot -ldflags "-X="github.com/devops-prometheus-course/03-dockerfile-makefile/cmd.appVersion=${VERSION}

image:
	docker build --build-arg ARCH=${ARCH} . -f Dockerfile.${OS} -t ${REGISTRY}/${APP}:${VERSION}-${OS}-${ARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${OS}-${ARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${OS}-${ARCH}
