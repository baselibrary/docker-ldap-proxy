NAME     = foundation/openldap
REPO     = git@github.com:baselibrary/docker-nexus.git
REGISTRY = thoughtworks.io
TAG      = 4.1.6

all: build

build:
	docker build --rm --tag=$(NAME):$(TAG) .;

push:
	docker tag -f ${NAME}:$(TAG) ${REGISTRY}/${NAME}:$(TAG); \
	docker push ${REGISTRY}/${NAME}:$(TAG); \
	docker rmi -f ${REGISTRY}/${NAME}:$(TAG); \

clean:
	docker rmi -f ${NAME}:$(TAG); \
	docker rmi -f ${REGISTRY}/${NAME}:$(TAG); \
