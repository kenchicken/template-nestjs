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
    ObjectUtil.copyMatchingFields(create<%= struct.name.pascalName %>Request, entity);
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (field.relatedType === 'OneToMany') { -%>
    entity.<%= field.name.lowerCamelName %> = [];
    if (update<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>) {
      for (const dto of update<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>) {
        const childEntity = new <%= field.structName.pascalName %>Entity();
        ObjectUtil.copyMatchingFields(dto, childEntity);
        childEntity.<%= struct.name.lowerCamelName %> = entity;
        // TODO 更にリレーションがある場合にはここに追記する
        entity.eventUsers.push(childEntity);
      }
    }
      <%_ } -%>
      <%_ if (field.relatedType === 'OneToOne') { -%>
      <%_ } -%>
      <%_ if (field.relatedType === 'ManyToOne') { -%>
    const <%= field.name.lowerCamelName %> = await this.<%= field.name.lowerCamelName %>Repository.get(
      create<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>ID,
    );
    if (!<%= field.name.lowerCamelName %>) {
      throw new Error('<%= field.name.lowerCamelName %> not found');
    }
    entity.<%= field.name.lowerCamelName %> = <%= field.name.lowerCamelName %>;
      <%_ } -%>
    <%_ }) -%>

    const result = await this.<%= struct.name.lowerCamelName %>Repository.update(id, entity);
    const response = new Update<%= struct.name.pascalName %>Response();
    ObjectUtil.copyMatchingFields(result, response);
    return response;
  }
}
