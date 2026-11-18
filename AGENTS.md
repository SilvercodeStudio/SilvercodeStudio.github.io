# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## Purpose

This repo is the GitHub Pages site for `https://silvercode.studio`. Silvercode Studio is the umbrella organization for Preston's open-source apps. The site presents those projects.

## Current state

The repo is new. It has only `README.md` and no commits. There is no site generator, build step, linter, or test suite yet. When content or tooling is added, update this file with the real commands and structure. Do not assume a framework (for example, Jekyll) until one is present in the repo.

## GitHub Pages notes

- The repo name `SilvercodeStudio.github.io` makes this an organization Pages site. GitHub publishes it from the default branch (`main`) unless the Pages settings say otherwise.
- When Pages publishes from a branch, the custom domain `silvercode.studio` needs a `CNAME` file at the publish root that contains only `silvercode.studio`. Do not remove or rename it after it is added.
- If the site is plain static HTML with no Jekyll, add an empty `.nojekyll` file at the publish root. Without it, GitHub runs Jekyll and skips files and folders that start with `_`.
