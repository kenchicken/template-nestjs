---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/controller/${struct.name.lowerKebabName}.controller.ts` : null %>"
force: true
---
import { Controller } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';

@Controller('<%= struct.name.lowerCamelName %>')
@ApiTags('<%= struct.name.pascalName %>')
export class <%= struct.name.pascalName %>Controller {
  constructor(
    // add handler here
  ) {}

  // add entry point here
}
