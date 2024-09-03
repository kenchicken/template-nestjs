---
to: "<%=  !struct.excludeGenerateAPI.search ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/search-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import { Search<%= struct.name.pascalName %>Condition } from 'src/app/repository/condition/generated/search-<%= struct.name.lowerKebabName %>.condition';
import Model<%= struct.name.pascalPluralName %> from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/model-<%= struct.name.lowerKebabPluralName %>';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';
import ObjectUtil from 'src/app/util/object-util';

@Injectable()
export class Search<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(condition: Search<%= struct.name.pascalName %>Condition): Promise<Model<%= struct.name.pascalPluralName %>> {
    const count = await this.<%= struct.name.lowerCamelName %>Repository.count(condition);
    const entities = await this.<%= struct.name.lowerCamelName %>Repository.getAll(condition);
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
  ): Promise<<%= struct.name.pascalName %>Dto> {
    const response = new <%= struct.name.pascalName %>Dto();
    ObjectUtil.copyMatchingFields(entity, response);
    return response;
  }
}
