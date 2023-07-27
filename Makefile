.PHONY: release

release:
	sed -i'' -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+/$(VERSION)/g' action.yml
	docker buildx build --platform linux/amd64 --push . -t beastawakens/action-convox-multi-slim:$(VERSION)
	git tag $(VERSION) -s -m $(VERSION) --force
	git push origin refs/tags/$(VERSION) --force