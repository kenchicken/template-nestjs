---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/controller/${struct.name.lowerKebabName}.controller.ts` : null %>"
force: true
---
import { Controller } from '@nestjs/common';

@Controller('<%= struct.name.lowerKebabName %>')
export class <%= struct.name.pascalName %>Controller {
  constructor(
    // add handler here
  ) {}

  // add entry point here
}
