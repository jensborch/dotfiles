# Sonar / GitHub conventions

- **Default Sonar project key = git repo name** (e.g. repo `Nykredit/ui-fix` → key `ui-fix`).
  Use this when `sonar-project.properties`, `pom.xml`, etc. do not declare `sonar.projectKey`.
  Verify with `mcp_io_github_son_search_my_sonarqube_projects` if a query returns nothing.
- **PR-scoped Sonar issues**: `mcp_io_github_son_search_sonar_issues_in_projects`
  with `projects: ["<key>"]` and `pullRequestId: <PR#>`.
- **Find PR# for current branch**: `mcp_io_github_git_list_pull_requests`
  with `head: "<owner>:<branch>"`.
