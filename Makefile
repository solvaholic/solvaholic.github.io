.PHONY: serve build new-post new-project clean tidy

HUGO ?= hugo

serve:
	$(HUGO) server --buildDrafts --disableFastRender --navigateToChanged

build:
	$(HUGO) --minify

# usage: make new-post TITLE="My new post"
new-post:
	@test -n "$(TITLE)" || (echo "TITLE is required" && exit 1)
	@slug=$$(echo "$(TITLE)" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$$//g'); \
	date=$$(date +%Y-%m-%d); \
	$(HUGO) new "posts/$${date}-$${slug}.md"

# usage: make new-project SLUG=my-project
new-project:
	@test -n "$(SLUG)" || (echo "SLUG is required" && exit 1)
	$(HUGO) new "projects/$(SLUG).md"

tidy:
	$(HUGO) mod tidy

clean:
	rm -rf public resources .hugo_build.lock
