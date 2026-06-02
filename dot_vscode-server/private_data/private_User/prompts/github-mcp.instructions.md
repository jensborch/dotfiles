---
applyTo: "**"
---
# Prefer the GitHub MCP server for GitHub operations

When the task involves interacting with GitHub (pull requests, issues, reviews,
review comments, branches, commits, releases, tags, repo search, or editing
files on a remote repo), you MUST prefer tools from the
`io.github.github/github-mcp-server` MCP server over alternatives.

These tools are exposed with the `mcp_io_github_git_*` prefix and may be
deferred — if a needed tool is not visible, load it first with `tool_search`
(e.g. query: "github pull request review comment").

## Tool preference order

1. **First choice:** `mcp_io_github_git_*` tools from the GitHub MCP server.
2. **Fallback only if no MCP tool exists** for the operation: the `gh` CLI via
   the terminal.
3. **Avoid:** scraping github.com via `fetch_webpage`, or hitting the REST API
   with `curl`, unless 1 and 2 are both unavailable.

Local `git` (status, add, commit, checkout, branch, diff, log, push to the
already-configured remote) remains the normal choice for local repo work —
this rule is about *remote GitHub interactions*, not local version control.

## Common task → tool map

When fixing issues on a PR, prefer:

- Read a PR (metadata, diff, files, review threads):
  `mcp_io_github_git_pull_request_read`
- List review comments / unresolved threads: same tool with the appropriate
  read method, not `gh pr view`.
- Reply to a specific review comment:
  `mcp_io_github_git_add_reply_to_pull_request_comment`
- Add a general PR comment: `mcp_io_github_git_add_issue_comment`
  (PR comments are issue comments on GitHub).
- Add a comment as part of a pending review:
  `mcp_io_github_git_add_comment_to_pending_review`
- Submit / write a PR review: `mcp_io_github_git_pull_request_review_write`
- Push fixes to the PR branch from the agent (when not using local git):
  `mcp_io_github_git_push_files` or
  `mcp_io_github_git_create_or_update_file`
- Update PR title/body/base: `mcp_io_github_git_update_pull_request`
- Update the PR branch with base: `mcp_io_github_git_update_pull_request_branch`
- Request a Copilot review: `mcp_io_github_git_request_copilot_review`
- Merge: `mcp_io_github_git_merge_pull_request` (only with explicit user
  confirmation — merging is destructive/irreversible per workspace rules).

For issues, branches, releases, tags, search, repo creation, etc., use the
correspondingly named `mcp_io_github_git_*` tool.

## Workflow: "fix issues on a PR"

1. Resolve the PR (owner/repo/number). If only a URL is given, parse it.
2. Use `mcp_io_github_git_pull_request_read` to fetch the PR, its diff, and
   review comments / unresolved threads. Do not guess what the reviewer asked
   for — read the actual comments.
3. Check out the PR branch locally with `git` (local git is fine here).
4. Make the code changes in the workspace using normal file-editing tools.
5. Run the project's tests / lint before pushing.
6. Commit and push with local `git` to the PR branch (normal flow), OR if no
   local checkout exists, use `mcp_io_github_git_push_files`.
7. Reply to each addressed review comment with
   `mcp_io_github_git_add_reply_to_pull_request_comment`, referencing the
   commit SHA that addresses it. Do not mark threads resolved unless the user
   asks.
8. Do not merge, force-push, or close the PR without explicit user
   confirmation.

## Anti-patterns to avoid

- Falling back to `gh pr view` / `gh pr review` just because they're familiar.
- Using `fetch_webpage` on a github.com PR URL to read review comments.
- Inventing tool names — if `mcp_io_github_git_<x>` is not listed, run
  `tool_search` with a description of the capability before assuming it
  doesn't exist.
- Force-push, branch deletion, PR close/merge without explicit confirmation.
