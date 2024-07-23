---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/controller/${struct.name.lowerKebabName}.controller.ts` : null %>"
force: true
---
import { Controller } from '@nestjs/common';
import { <%= struct.name.pascalName %>ServiceGenerated } from '../service';
import {ApiTags} from "@nestjs/swagger";

@Controller('<%= struct.name.lowerKebabName %>')
@ApiTags('<%= struct.name.lowerKebabName %>')
export class <%= struct.name.pascalName %>Controller {
  constructor(
    private readonly <%= struct.name.lowerCamelName %>ServiceGenerated: <%= struct.name.pascalName %>ServiceGenerated,
    // add handler here
  ) {}

  // add entry point here
}
