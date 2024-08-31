---
to: "<%= !struct.excludeGenerateAPI.get ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/find-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Find<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/find-<%= struct.name.lowerKebabName %>.response';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
<%_ let hasOneToMany = false; -%>
<%_ let hasManyToOne = false; -%>
<%_ let importStructs = []; -%>
<%_ let importStructNames = []; -%>
<%_ struct.fields.forEach(function (field, key) { -%>
<%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
  <%_ hasOneToMany = true; -%>
  <%_ if (!importStructNames.includes(field.structName.pascalName)) { -%>
    <%_ importStructs.push(field.structName); -%>
    <%_ importStructNames.push(field.structName.pascalName); -%>
  <%_ } -%>
<%_ } -%>
<%_ if (field.relatedType === 'OneToOne' && field.dbTags.indexOf('->;') === -1) { -%>
<%_ } -%>
<%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
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
  import <%= structName.pascalName %>Dto from 'src/app/dto/<%= structName.lowerKebabName %>.dto';
<%_ }) -%>

import ObjectUtil from 'src/app/util/object-util';

@Injectable()
export class Find<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(id: number, loginUserID: number): Promise<Find<%= struct.name.pascalName %>Response> {
    const result = await this.<%= struct.name.lowerCamelName %>Repository.get(id);
    return await this.convertEntityToResponse(result);
  }

  private async convertEntityToResponse(
    entity: <%= struct.name.pascalName %>Entity,
  ): Promise<Find<%= struct.name.pascalName %>Response> {
    const response = new Find<%= struct.name.pascalName %>Response();
    ObjectUtil.copyMatchingFields(entity, response);
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
    response.<%= field.name.lowerCamelName %> = [];
    if (entity.<%= field.name.lowerCamelName %>) {
      for (const childEntity of entity.<%= field.name.lowerCamelName %>) {
        const childDto = new <%= field.structName.pascalName %>Dto();
        ObjectUtil.copyMatchingFields(childEntity, childDto);
        response.<%= field.name.lowerCamelName %>.push(childDto);
      }
    }
    <%_ } -%>
    <%_ if (field.relatedType === 'OneToOne' && field.dbTags.indexOf('->;') === -1) { -%>
    <%_ } -%>
    <%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
    const <%= field.relatedStructName.lowerCamelName %>Dto = new <%= field.relatedStructName.pascalName %>Dto();
    ObjectUtil.copyMatchingFields(entity.<%= field.relatedStructName.lowerCamelName %>, <%= field.relatedStructName.lowerCamelName %>Dto);
    response.<%= field.relatedStructName.lowerCamelName %> = <%= field.relatedStructName.lowerCamelName %>Dto;
      <%_ } -%>
    <%_ }) -%>
    return response;
  }
}
