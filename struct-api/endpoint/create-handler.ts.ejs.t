---
to: "<%= !struct.excludeGenerateAPI.create ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/create-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
<%_ struct.fields.forEach(function (field, key) { -%>
<%_ if (field.relatedType === 'OneToMany') { -%>
import <%= field.structName.pascalName %>Entity from './<%= field.structName.lowerKebabName %>.entity';
<%_ } -%>
<%_ if (field.relatedType === 'OneToOne') { -%>
<%_ } -%>
<%_ if (field.relatedType === 'ManyToOne') { -%>
<%_ } -%>
<%_ }) -%>
<%_ } -%>

@Injectable()
export class Create<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(create<%= struct.name.pascalName %>Dto: <%= struct.name.pascalName %>Dto): Promise<<%= struct.name.pascalName %>Entity> {
    const entity = new <%= struct.name.pascalName %>Entity();
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (field.dataType === 'string') { -%>
    entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'number') { -%>
    entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'time') { -%>
    entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.dataType === 'bool') { -%>
    entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>;
      <%_ } -%>
      <%_ if (field.relatedType === 'OneToMany') { -%>
    if (create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>) {
      entity.<%= field.name.lowerCamelName %> = create<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>.map((dto) => {
        const childEntity = new UserEducationalBackgroundEntity();
        childEntity.major = dto.major;
        childEntity.graduationYear = dto.graduationYear;
        childEntity.order = dto.order;
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

    return await this.<%= struct.name.lowerCamelName %>Repository.create(entity);
  }
}
