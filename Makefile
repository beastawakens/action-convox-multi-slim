.PHONY: release

DOCKER_REPO := beastawakens/action-convox-multi-slim

release:
ifndef VERSION
	$(error VERSION is not set. Usage: VERSION=v1.x.x make release)
endif
	@echo "Checking Docker daemon status..."
	@docker info > /dev/null 2>&1 || { echo "Error: Docker daemon is not running. Please start Docker first."; exit 1; }
	@echo "Checking Docker Hub login status..."
	@test -f ~/.docker/config.json && cat ~/.docker/config.json | grep -q "index.docker.io" || { echo "Error: Not logged into Docker Hub. Please run 'docker login' first."; exit 1; }
	@echo "Docker checks passed. Proceeding with release $(VERSION)..."
	@echo "$(VERSION)" > VERSION
	sed -i'.bak' 's|\(image:.*:\)[^'\'']*|\1$(VERSION)|' action.yml
	sed -i'.bak' 's|\(LABEL version=\)"[^"]*"|\1"$(VERSION)"|' Dockerfile
	git diff --quiet || git commit -am "Release $(VERSION)"
	docker buildx build --platform linux/amd64 --push . -t $(DOCKER_REPO):$(VERSION)
	git tag $(VERSION) -s -m $(VERSION) --force
	git push origin refs/tags/$(VERSION) --force
	git push