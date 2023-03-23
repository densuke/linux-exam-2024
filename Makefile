IMAGE=densukest/ubuntu-it-soft:v1
PASSWORD=penguin

all: build

build:
	-docker buildx create --use --name mybuild
	docker buildx build --platform=linux/amd64,linux/arm64 --push --build-arg PASSWORD=$(PASSWORD) \
		-t $(IMAGE) src

clean:
	docker image rm $(IMAGE)
