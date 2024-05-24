#IMAGE=densukest/ubuntu-it-soft:v2
IMAGE=ghcr.io/densuke-st/linux-vm-docker:3
PASSWORD=penguin
DESTDIR=/usr/local/lib/linuxvm-docker
LINK=/usr/local/bin

all: build

build:
	docker build --build-arg PASSWORD=$(PASSWORD) \
		-t $(IMAGE) src

push: build
	docker push $(IMAGE)

clean:
	docker image rm $(IMAGE)

install:
	install -d -m 0755 $(DESTDIR)
	install -m 0644 config $(DESTDIR)
	install -m 0644 docker-compose.yml $(DESTDIR)
	for item in start stop setup reset; do \
		install -m 0755 linux-$${item} $(DESTDIR); \
		ln -sf $(DESTDIR)/linux-$${item} $(LINK); \
	done

uninstall:
	for item in start stop setup reset; do \
		rm -f $(LINK)/linux-$${item}; \
	done
	rm -fr $(DESTDIR)

test: build
	@echo "after test, run 'make down' to stop the container	"
	docker compose -f docker-compose.yml -f docker-compose_test.yml up -d

down:
	docker compose -f docker-compose.yml -f docker-compose_test.yml \
		down -v --remove-orphans

.PHONY: all build push clean install uninstall test down
