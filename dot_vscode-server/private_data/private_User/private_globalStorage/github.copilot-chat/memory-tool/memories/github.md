# GitHub conventions

- **Prefer GitHub MCP** (`mcp_io_github_git_*`) over `fetch_webpage` for any GitHub.com info:
  repo contents, READMEs, PRs, issues, branches, releases, code search. Faster, auth'd,
  no HTML scraping. Use `get_file_contents` for files/dirs, `search_code` for code search.
- **Find PR# for current branch**: `mcp_io_github_git_list_pull_requests` with `head: "<owner>:<branch>"`.
