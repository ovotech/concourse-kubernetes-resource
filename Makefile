all: build push
test: build pushtest

build:
	docker build -t mdaley/concourse-kubernetes-resource:local .

push:
	docker tag mdaley/concourse-kubernetes-resource:local mdaley/concourse-kubernetes-resource:latest
	docker push mdaley/concourse-kubernetes-resource:latest

pushtest:
	docker tag mdaley/concourse-kubernetes-resource:local mdaley/concourse-kubernetes-resource:test
	docker push mdaley/concourse-kubernetes-resource:test
