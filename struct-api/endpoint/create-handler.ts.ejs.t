---
to: "<%= !struct.excludeGenerateAPI.create ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/create-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Create<%= struct.name.pascalName %>Request from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/create-<%= struct.name.lowerKebabName %>.request';
import Create<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/create-<%= struct.name.lowerKebabName %>.response';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
<%_ let hasOneToMany = false; -%>
<%_ let hasManyToOne = false; -%>
<%_ let importStructs = []; -%>
<%_ let importStructNames = []; -%>
<%_ struct.fields.forEach(function (field, key) { -%>
<%_ if (field.relatedType === 'OneToMany') { -%>
  <%_ hasOneToMany = true; -%>
  <%_ if (!importStructNames.includes(field.structName.pascalName)) { -%>
    <%_ importStructs.push(field.structName); -%>
    <%_ importStructNames.push(field.structName.pascalName); -%>
  <%_ } -%>
<%_ } -%>
<%_ if (field.relatedType === 'OneToOne') { -%>
<%_ } -%>
<%_ if (field.relatedType === 'ManyToOne') { -%>
  <%_ hasManyToOne = true; -%>
  <%_ if (!importStructNames.includes(field.relatedStructName.pascalName)) { -%>
    <%_ importStructs.push(field.relatedStructName); -%>
    <%_ importStructNames.push(field.relatedStructName.pascalName); -%>
  <%_ } -%>
<%_ } -%>
<%_ }) -%>
<%_ importStructs.forEach(function (structName, key) { -%>
import <%= structName.pascalName %>Entity from 'src/app/entity/<%= structName.lowerKebabName %>.entity';
import { <%= structName.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= structName.lowerKebabName %>.repository.interface.generated';
<%_ }) -%>
import ObjectUtil from 'src/app/util/object-util';

@Injectable()
export class Create<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
<%_ importStructs.forEach(function (structName, key) { -%>
    @Inject('<%= structName.lowerCamelName %>RepositoryGenerated')
    private readonly <%= structName.lowerCamelName %>Repository: <%= structName.pascalName %>RepositoryInterfaceGenerated,
<%_ }) -%>
  ) {}

  async exec(request: Create<%= struct.name.pascalName %>Request): Promise<Create<%= struct.name.pascalName %>Response> {
    const entity = new <%= struct.name.pascalName %>Entity();
    ObjectUtil.copyMatchingFields(request, entity);
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (field.relatedType === 'OneToMany' && !field.dbTags.includes('->;')) { -%>
    entity.<%= field.name.lowerCamelName %> = [];
    if (request.<%= field.name.lowerCamelName %>) {
      for (const dto of request.<%= field.name.lowerCamelName %>) {
        const childEntity = new <%= field.structName.pascalName %>Entity();
        ObjectUtil.copyMatchingFields(dto, childEntity);
        childEntity.<%= struct.name.lowerCamelName %> = entity;
        // TODO 更にリレーションがある場合にはここに追記する
        entity.<%= field.name.lowerCamelName %>.push(childEntity);
      }
    }
      <%_ } -%>
      <%_ if (field.relatedType === 'OneToOne' && !field.dbTags.includes('->;')) { -%>
      <%_ } -%>
      <%_ if (field.relatedType === 'ManyToOne' && !field.dbTags.includes('->;')) { -%>
    const <%= field.relatedStructName.lowerCamelName %>: <%= field.relatedStructName.pascalName %>Entity = await this.<%= field.relatedStructName.lowerCamelName %>Repository.get(
      request.<%= field.name.lowerCamelName %>,
    );
    if (!<%= field.relatedStructName.lowerCamelName %>) {
      throw new Error('<%= field.name.lowerCamelName %> not found');
    }
    entity.<%= field.relatedStructName.lowerCamelName %> = <%= field.relatedStructName.lowerCamelName %>;
      <%_ } -%>
    <%_ }) -%>

    const result = await this.<%= struct.name.lowerCamelName %>Repository.create(entity);
    const response = new Create<%= struct.name.pascalName %>Response();
    ObjectUtil.copyMatchingFields(result, response);
    return response;
  }
}
