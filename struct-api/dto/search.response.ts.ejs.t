---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/dto/model-${struct.name.lowerKebabPluralName}.ts` : null %>"
force: true
---
import { ApiProperty } from '@nestjs/swagger';
import Model<%= struct.name.pascalName %> from 'src/app/dto/model-<%= struct.name.lowerKebabName %>';

export default class Model<%= struct.name.pascalPluralName %> {
  @ApiProperty({
    required: false,
    nullable: true,
    isArray: true,
    type: Model<%= struct.name.pascalName %>,
  })
  <%= struct.name.lowerCamelPluralName %>: Model<%= struct.name.pascalName %>[];

  @ApiProperty({
    required: false,
    nullable: true,
  })
  count: number;
}
