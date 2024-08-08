---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/query/index.ts` : null %>"
force: true
---
// add import query here

export class queryManifest {
  package: string;
}
