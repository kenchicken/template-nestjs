---
to: <%= rootDirectory %>/api/tsconfig.build.json
force: true
---
{
  "extends": "./tsconfig.json",
  "exclude": ["node_modules", "test", "dist", "**/*spec.ts"]
}
