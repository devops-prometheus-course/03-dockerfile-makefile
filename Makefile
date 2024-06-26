APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=manchy
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
OS=linux#darwin windows
ARCH=amd64#arm64

format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

build: format get
	CGO_ENABLED=0 GOOS=${OS} GOARCH=${ARCH} go build -v -o kbot -ldflags "-X="github.com/devops-prometheus-course/03-dockerfile-makefile/cmd.appVersion=${VERSION}

image:
	docker build --build-arg OS=${OS} --build-arg ARCH=${ARCH} . -t ${REGISTRY}/${APP}:${VERSION}-${OS}-${ARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${OS}-${ARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${OS}-${ARCH}
