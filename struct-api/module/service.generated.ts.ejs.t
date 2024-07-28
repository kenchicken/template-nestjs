---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/service/${struct.name.lowerKebabName}.service.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import { Create<%= struct.name.pascalName %>Dto } from '../dto/generated/create-<%= struct.name.lowerKebabName %>.dto';
import { Update<%= struct.name.pascalName %>Dto } from '../dto/generated/update-<%= struct.name.lowerKebabName %>.dto';
import { Search<%= struct.name.pascalName %>Dto } from '../dto/generated/search-<%= struct.name.lowerKebabName %>.dto';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';

@Injectable()
export class <%= struct.name.pascalName %>ServiceGenerated {
  constructor(
    @Inject('repositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async create(create<%= struct.name.pascalName %>Dto: Create<%= struct.name.pascalName %>Dto): Promise<<%= struct.name.pascalName %>Entity> {
    return await this.<%= struct.name.lowerCamelName %>Repository.create({
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (!field.related) { -%>
      <%_ if (field.dataType === 'string') { -%>
      <%= field.name.lowerCamelName %>: create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'number') { -%>
      <%= field.name.lowerCamelName %>: create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'time') { -%>
      <%= field.name.lowerCamelName %>: create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ if (field.dataType === 'bool') { -%>
      <%= field.name.lowerCamelName %>: create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ } -%>
      <%_ } -%>
    <%_ }) -%>
    });
  }

  async findAll(condition: Search<%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Repository.getAll(condition);
  }

  async findOneById(id: number) {
    return await this.<%= struct.name.lowerCamelName %>Repository.get(id);
  }

  async update(id: number, update<%= struct.name.pascalName %>Dto: Update<%= struct.name.pascalName %>Dto) {
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

  async remove(id: number) {
    return await this.<%= struct.name.lowerCamelName %>Repository.delete(id);
  }
}
