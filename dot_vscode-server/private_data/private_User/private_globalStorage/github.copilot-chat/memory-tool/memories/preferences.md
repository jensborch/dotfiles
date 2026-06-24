# Preferences

## Nx MCP server

- Never start the Nx MCP server (`nx-mcp`) unless:
  1. The workspace is an Nx project, AND
  2. A `.vscode/mcp.json` in the workspace root already declares the Nx MCP server.
- If neither condition is met, proceed without the Nx MCP server and do not suggest starting it.

## Git workflow

- Never commit or push changes on the user's behalf. Always stop after editing files — the user reviews and pushes themselves.
- After editing files, always provide a ready-to-use conventional commit message the user can copy.
