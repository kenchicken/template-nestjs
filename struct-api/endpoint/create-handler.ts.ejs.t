---
to: "<%= !struct.excludeGenerateAPI.create ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/create-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Create<%= struct.name.pascalName %>Request from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/create-<%= struct.name.lowerKebabName %>.request';
import Create<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/create-<%= struct.name.lowerKebabName %>.response';
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
export class Create<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(create<%= struct.name.pascalName %>Request: Create<%= struct.name.pascalName %>Request): Promise<Create<%= struct.name.pascalName %>Response> {
    const entity = new <%= struct.name.pascalName %>Entity();
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (field.dataType === 'string') { -%>
    entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'number') { -%>
    entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'time') { -%>
    entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'bool') { -%>
    entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.relatedType === 'OneToMany') { -%>
    if (create<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>) {
      entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Request.<%= field.name.lowerCamelName %>.map((dto) => {
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

    const result = await this.<%= struct.name.lowerCamelName %>Repository.create(entity);
    const response = new Create<%= struct.name.pascalName %>Response();
    ObjectUtil.copyMatchingFields(result, response);
    return response;
  }
}
