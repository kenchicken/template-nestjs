---
to: "<%=  !struct.excludeGenerateAPI.update ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/update-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Update<%= struct.name.pascalName %>Request from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/update-<%= struct.name.lowerKebabName %>.request';
import Update<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/update-<%= struct.name.lowerKebabName %>.response';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
<%_ let hasOneToMany = false; -%>
<%_ struct.fields.forEach(function (field, key) { -%>
<%_ if (field.relatedType === 'OneToMany') { -%>
<%_ hasOneToMany = true; -%>
import <%= field.structName.pascalName %>Entity from 'src/app/entity/<%= field.structName.lowerKebabName %>.entity';
<%_ } -%>
<%_ if (field.relatedType === 'OneToOne') { -%>
<%_ } -%>
<%_ if (field.relatedType === 'ManyToOne') { -%>
<%_ } -%>
<%_ }) -%>
import ObjectUtil from 'src/app/util/object-util';

@Injectable()
export class Update<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(id: number, update<%= struct.name.pascalName %>Request: Update<%= struct.name.pascalName %>Request): Promise<Update<%= struct.name.pascalName %>Response> {
    const entity = new <%= struct.name.pascalName %>Entity();
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (field.dataType === 'string') { -%>
    entity.<%= field.name.lowerCamelName %> = update<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'number') { -%>
    entity.<%= field.name.lowerCamelName %> = update<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'time') { -%>
    entity.<%= field.name.lowerCamelName %> = update<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'bool') { -%>
    entity.<%= field.name.lowerCamelName %> = update<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.relatedType === 'OneToMany') { -%>
    if (update<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>) {
      entity.<%= field.name.lowerCamelName %> = update<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>.map((dto) => {
        const childEntity = new <%= field.structName.pascalName %>Entity();
        ObjectUtil.copyMatchingFields(dto, childEntity);
        childEntity.<%= struct.name.lowerCamelName %> = entity;
        return childEntity;
      });
    }
      <%_ } -%>
      <%_ if (field.relatedType === 'OneToOne') { -%>
      <%_ } -%>
      <%_ if (field.relatedType === 'ManyToOne') { -%>
      <%_ } -%>
    <%_ }) -%>

    const result = await this.<%= struct.name.lowerCamelName %>Repository.update(id, entity);
    const response = new Update<%= struct.name.pascalName %>Response();
    ObjectUtil.copyMatchingFields(result, response);
    return response;
  }
}
