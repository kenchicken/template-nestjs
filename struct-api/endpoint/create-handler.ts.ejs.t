---
to: "<%= !struct.excludeGenerateAPI.create ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/create-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';

@Injectable()
export class Create<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(create<%= struct.name.pascalName %>Dto: <%= struct.name.pascalName %>Dto): Promise<<%= struct.name.pascalName %>Entity> {
    return await this.<%= struct.name.lowerCamelName %>Repository.create({
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (!field.related) { -%>
      <%_ if (field.dataType === 'string') { -%>
      <%= field.name.lowerCamelName %>: create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'number') { -%>
      <%= field.name.lowerCamelName %>: create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'time') { -%>
      <%= field.name.lowerCamelName %>: create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'bool') { -%>
      <%= field.name.lowerCamelName %>: create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ } -%>
    <%_ }) -%>
    });
  }
}
