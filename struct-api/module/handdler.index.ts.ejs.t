---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/service/handler/index.ts` : null %>"
force: true
---
// add import handler here

export class handlerManifest {
  package: string;
}
