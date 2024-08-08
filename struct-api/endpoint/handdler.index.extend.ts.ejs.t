---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/index.extend.ts` : null %>"
force: true
---
// add import handler here

export class handlerManifest {
  package: string;
}
