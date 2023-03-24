IMAGE=densukest/ubuntu-it-soft:v1
PASSWORD=penguin

all: build

build:
	docker build --build-arg PASSWORD=$(PASSWORD) \
		-t $(IMAGE) src

push: build
	docker push $(IMAGE)

clean:
	docker image rm $(IMAGE)
