---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/service/query/index.ts` : null %>"
force: true
---
// add import query here

export class queryManifest {
  package: string;
}
