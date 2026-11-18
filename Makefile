# Shortcuts for working on the Silvercode Studio website.
#
#   make site
#   make lint
#
# The site is plain static HTML and CSS at the repo root. GitHub Pages publishes only the
# files in SITE_FILES: make build copies them to _site, and .github/workflows/pages.yml
# uploads that folder.

# What the site is made of. Add new top-level pages and folders here.
SITE_FILES = *.html css js images CNAME
BUILD_DIR = _site

# Silverside's make site also uses 8000; set PORT=8001 to run both at once.
PORT ?= 8000

# Text files with spaces or tabs at the ends of lines; .editorconfig has editors trim them.
WHITESPACE_EXCEPTIONS = ':!*.svg'

.PHONY: help site build lint

help:
	@echo "make site           serve the website (the repo root) at http://localhost:$(PORT)"
	@echo "make build          copy the published files to $(BUILD_DIR), as the Pages workflow does"
	@echo "make lint           report broken local links and spaces at the ends of lines"
	@echo "Set PORT=n to use a different port."

# The website, as GitHub Pages serves it.
site:
	python3 -m http.server $(PORT) --bind 127.0.0.1

build:
	rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)
	cp -R $(SITE_FILES) $(BUILD_DIR)/

lint:
	@scripts/check-links.pl *.html
	@if git grep -nI --untracked -E '[[:blank:]]+$$' -- . $(WHITESPACE_EXCEPTIONS); then \
		echo "Spaces or tabs at the end of the lines above: remove them."; exit 1; fi
