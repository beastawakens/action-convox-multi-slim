.PHONY: release

release:
	sed -i'.bak' 's/\(image:.*:\)[^"]*/\1$(VERSION)/' action.yml
	git commit -am "Release $(VERSION)"
	docker buildx build --platform linux/amd64 --push . -t beastawakens/action-convox-multi-slim:$(VERSION)
	git tag $(VERSION) -s -m $(VERSION) --force
	git push origin refs/tags/$(VERSION) --force