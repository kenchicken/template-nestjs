---
to: "<%=  !struct.excludeGenerateAPI.update ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/update-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Create<%= struct.name.pascalName %>Request from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/create-<%= struct.name.lowerKebabName %>.request';
import Create<%= struct.name.pascalName %>Response from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/create-<%= struct.name.lowerKebabName %>.response';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';

@Injectable()
export class Update<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(id: number, update<%= struct.name.pascalName %>Request: Update<%= struct.name.pascalName %>Request): Promise<Update<%= struct.name.pascalName %>Response> {
    return await this.<%= struct.name.lowerCamelName %>Repository.update(id, {
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (!field.related) { -%>
      <%_ if (field.dataType === 'string') { -%>
      <%= field.name.lowerCamelName %>: update<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'number') { -%>
      <%= field.name.lowerCamelName %>: update<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'time') { -%>
      <%= field.name.lowerCamelName %>: update<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'bool') { -%>
      <%= field.name.lowerCamelName %>: update<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ } -%>
    <%_ }) -%>
    });
  }
}
