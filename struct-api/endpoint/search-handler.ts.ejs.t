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
      response.<%= struct.name.lowerCamelPluralName %>.push(await this.convertEntityToResponse(entity));
    }
    return response;
  }

  private async convertEntityToResponse(
    entity: <%= struct.name.pascalName %>Entity,
  ): Promise<Model<%= struct.name.pascalName %>> {
    const response = new Model<%= struct.name.pascalName %>();
    ObjectUtil.copyMatchingFields(entity, response);
    <%_ struct.fields.forEach(function (field, key) { -%>
    <%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
      response.<%= field.name.lowerCamelName %> = [];
      if (entity.<%= field.name.lowerCamelName %>) {
      for (const childEntity of entity.<%= field.name.lowerCamelName %>) {
      const childModel = new Model<%= field.structName.pascalName %>();
      ObjectUtil.copyMatchingFields(childEntity, childModel);
      response.<%= field.name.lowerCamelName %>.push(childModel);
      }
      }
    <%_ } -%>
    <%_ if (field.relatedType === 'OneToOne' && field.dbTags.indexOf('->;') === -1) { -%>
    <%_ } -%>
    <%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
      const <%= field.relatedStructName.lowerCamelName %>Model = new Model<%= field.relatedStructName.pascalName %>();
      ObjectUtil.copyMatchingFields(entity.<%= field.relatedStructName.lowerCamelName %>, <%= field.relatedStructName.lowerCamelName %>Model);
      response.<%= field.relatedStructName.lowerCamelName %> = <%= field.relatedStructName.lowerCamelName %>Model;
    <%_ } -%>
    <%_ }) -%>
    return response;
  }
}
