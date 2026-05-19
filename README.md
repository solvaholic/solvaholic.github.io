# solvaholic.github.io

Source for [solvaholic.com](https://solvaholic.com). Built with
[Hugo](https://gohugo.io/) and the
[PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme,
deployed to GitHub Pages via Actions.

The pre-Hugo Jekyll site is preserved at the
`archive/jekyll-2021` tag.

## Local development

Requirements: `hugo` (extended) and `go` (for Hugo modules).

```sh
brew install hugo go
make serve              # http://localhost:1313
```

## Authoring

```sh
make new-post TITLE="My new post"
make new-project SLUG=cool-thing
```

Posts land in `content/posts/` as drafts. Flip `draft: false` in the
front matter when ready. Push to `main` and the deploy workflow does
the rest.

### Drafting from an agent session

```sh
script/draft-from-session.sh "Post title" /path/to/session-summary.md
```

Scaffolds a draft with the session notes inlined under `## Notes` so you
can edit them into prose.

## Layout

```
archetypes/         front-matter templates for `hugo new`
config/_default/    site config (split: hugo, params, menus, module)
content/
  about.md
  projects/         landing page + one file per project
  posts/            blog posts (YYYY-MM-DD-slug.md)
static/             served as-is (CNAME, favicon, images)
```

## Deploy

`main` -> `.github/workflows/deploy.yml` -> GitHub Pages.

One-time repo setting: **Settings -> Pages -> Source: GitHub Actions**.

## Dependency updates

- **Theme + Go modules**: Dependabot (`gomod` ecosystem) weekly.
- **GitHub Actions**: Dependabot weekly.
- **Hugo binary**: `.github/workflows/bump-hugo.yml` opens a PR
  weekly when a newer Hugo release is available.

## License

[MIT](LICENSE).
