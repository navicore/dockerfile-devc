.PHONY: build shell clean

IMAGE_NAME=localhost/dev-env:latest

build:
	podman build -t $(IMAGE_NAME) .

shell:
	podman run --rm -it \
		-v $(HOME)/.kube:/root/.kube \
		-v $(PWD):/workspace \
		--privileged \
		$(IMAGE_NAME)

clean:
	podman rmi $(IMAGE_NAME)

