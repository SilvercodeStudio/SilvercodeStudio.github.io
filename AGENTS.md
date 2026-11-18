# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## Purpose

This repo is the GitHub Pages site for `https://silvercode.studio`. Silvercode Studio is the umbrella organization for Preston's open-source apps. The site presents those projects.

## Structure

The site is plain static HTML and CSS at the repo root, with no generator or framework. Do not add one (for example, Jekyll) unless asked.

- `index.html` is the home page. It lists the apps as cards.
- `sponsor.html` lists the ways to tip, one card each. The apps link to it as `https://silvercode.studio/sponsor` (GitHub Pages serves `sponsor.html` there), so keep that address working. Links inside the site use `sponsor.html`, because `make site` and `make lint` do not know the short form. A way to tip that is not ready yet shows a "Coming soon" chip, and an HTML comment in its card holds the button to add.
- Every page has the same nav and footer, written out in each file. When you change one, change all pages.
- `css/tokens.css` and `css/site.css` started as copies of Silverside's (`../Silverside/docs/site/css`), so the studio and the apps share one look. `site.css` no longer has Silverside's HDCD and DTS rules. When you change a shared rule, consider the same change in Silverside's copy. The studio's own rules go in `css/studio.css`, not in `site.css`.
- `js/site.js` is the theme part and the phone-menu part of Silverside's `js/site.js`. It shows the theme buttons, sets `data-theme` on `<html>`, and keeps a choice in `localStorage` only while it differs from the system appearance. A short script in `<head>` applies the stored choice before the page draws. Without JavaScript, the page follows the system appearance.
- Images: `images/icon.png` is the studio icon, and `images/apple-touch-icon.png` is the same picture. `images/silverbox.png` and `images/silverplay.png` are the full-size app icons; the studio uses the Silverbox floppy disk as its own icon. The pages show 256 px copies (`silverbox-256.png`, `silverplay-256.png`, made with `sips -Z 256 in.png --out out.png`), as the full-size files are up to 2 MB. When an app icon changes, make its copy again.
- `.editorconfig` sets the style: LF line ends, a final newline, no spaces at line ends, and 2-space indents in HTML, CSS, and YAML.

## Commands

- `make site` serves the repo root at `http://localhost:8000`. Silverside's `make site` also uses port 8000; set `PORT=8001` to run both.
- `make lint` reports broken local links in `*.html` (`scripts/check-links.pl`) and spaces or tabs at line ends.
- `make build` copies the published files (`SITE_FILES` in the `Makefile`) to `_site/`.

## Publishing

`.github/workflows/pages.yml` runs `make lint` and `make build` on each push to `main`, then deploys `_site/` to GitHub Pages. A broken link stops the deploy. Only the files in `SITE_FILES` are published, so `README.md`, `AGENTS.md`, `Makefile`, and `scripts/` stay off the site. When you add a new top-level page or folder, `*.html` already covers pages; add a new folder to `SITE_FILES`.

Because the workflow publishes the site, GitHub does not run Jekyll, and no `.nojekyll` file is needed. The custom domain is set in the repo's Settings › Pages; the workflow ignores `CNAME`, but it stays as a record of the domain.
