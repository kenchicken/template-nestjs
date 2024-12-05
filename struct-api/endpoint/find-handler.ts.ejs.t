---
to: "<%= !struct.excludeGenerateAPI.get ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/find-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Model<%= struct.name.pascalName %> from 'src/app/dto/model-<%= struct.name.lowerKebabName %>';
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
import Model<%= structName.pascalName %> from 'src/app/dto/model-<%= structName.lowerKebabName %>';
<%_ }) -%>
import ObjectUtil from 'src/app/util/object-util';
import { convertEntityToResponse } from '../dto-converter';

@Injectable()
export class Find<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(id: number, loginUserID?: number): Promise<Model<%= struct.name.pascalName %>> {
    const result = await this.<%= struct.name.lowerCamelName %>Repository.get(id, { all: true });
    return await convertEntityToResponse(result);
  }
}
