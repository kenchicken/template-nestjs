---
to: "<%=  !struct.excludeGenerateAPI.search ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/search-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Search<%= struct.name.pascalName %>Condition from 'src/app/dto/search-<%= struct.name.lowerKebabName %>.condition';
import Model<%= struct.name.pascalPluralName %> from 'src/app/dto/model-<%= struct.name.lowerKebabPluralName %>';
import Model<%= struct.name.pascalName %> from 'src/app/dto/model-<%= struct.name.lowerKebabName %>';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import ObjectUtil from 'src/app/util/object-util';
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
import { convertEntityToResponse } from '../dto-converter';

@Injectable()
export class Search<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(condition: Search<%= struct.name.pascalName %>Condition): Promise<Model<%= struct.name.pascalPluralName %>> {
    const count = await this.<%= struct.name.lowerCamelName %>Repository.count(condition);
    const entities = await this.<%= struct.name.lowerCamelName %>Repository.getAll(condition, { all: true });
    const response = new Model<%= struct.name.pascalPluralName %>();
    response.<%= struct.name.lowerCamelPluralName %> = [];
    response.count = count;
    for (const entity of entities) {
      response.<%= struct.name.lowerCamelPluralName %>.push(await convertEntityToResponse(entity));
    }
    return response;
  }
}
