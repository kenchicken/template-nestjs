---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/generated/model-${struct.name.lowerKebabPluralName}.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';

export default class Model<%= struct.name.pascalPluralName %> {
  @ApiProperty({
    required: false,
    nullable: true,
    isArray: true,
    type: <%= struct.name.pascalName %>Dto,
  })
  <%= struct.name.lowerCamelPluralName %>: <%= struct.name.pascalName %>Dto[];

  @ApiProperty({
    required: false,
    nullable: true,
  })
  count: number;
}
