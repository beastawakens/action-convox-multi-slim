.PHONY: release

release:
ifndef VERSION
	$(error VERSION is not set. Usage: VERSION=v1.x.x make release)
endif
	@echo "Proceeding with release $(VERSION)..."
	@echo "$(VERSION)" > VERSION
	git diff --quiet || git commit -am "Release $(VERSION)"
	git tag $(VERSION) -s -m $(VERSION) --force
	git push origin refs/tags/$(VERSION) --force
	git push