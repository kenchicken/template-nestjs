---
to: "<%=  !struct.excludeGenerateAPI.update ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/patch-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
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
import <%= structName.pascalName %>Entity from 'src/app/entity/<%= structName.lowerKebabName %>.entity';
import { <%= structName.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= structName.lowerKebabName %>.repository.interface.generated';
import Model<%= structName.pascalName %> from 'src/app/dto/model-<%= structName.lowerKebabName %>';
<%_ }) -%>
import ObjectUtil from 'src/app/util/object-util';
import { Transactional } from 'typeorm-transactional';

@Injectable()
export class Patch<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
<%_ importStructs.forEach(function (structName, key) { -%>
    @Inject('<%= structName.lowerCamelName %>RepositoryGenerated')
    private readonly <%= structName.lowerCamelName %>Repository: <%= structName.pascalName %>RepositoryInterfaceGenerated,
<%_ }) -%>
  ) {}

  @Transactional()
  async exec(id: number, request: Model<%= struct.name.pascalName %>): Promise<Model<%= struct.name.pascalName %>> {
    const orgEntity = await this.<%= struct.name.lowerCamelName %>Repository.get(id);
    const entity = await this.mergeRequestToEntity(request, orgEntity);
    const result = await this.<%= struct.name.lowerCamelName %>Repository.update(orgEntity.id, entity);
    return await this.convertEntityToResponse(result);
  }

  private async mergeRequestToEntity(
    request: Model<%= struct.name.pascalName %>,
    entity: <%= struct.name.pascalName %>Entity,
  ): Promise<<%= struct.name.pascalName %>Entity> {
    ObjectUtil.patchMatchingFields(request, entity);
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
    if (request.<%= field.name.lowerCamelName %>) {
      entity.<%= field.name.lowerCamelName %> = [];
      for (const dto of request.<%= field.name.lowerCamelName %>) {
        const childEntity = new <%= field.structName.pascalName %>Entity();
        ObjectUtil.patchMatchingFields(dto, childEntity);
        childEntity.<%= struct.name.lowerCamelName %> = entity;
        // TODO 更にリレーションがある場合にはここに追記する
        entity.<%= field.name.lowerCamelName %>.push(childEntity);
      }
    }
      <%_ } -%>
      <%_ if (field.relatedType === 'OneToOne' && field.dbTags.indexOf('->;') === -1) { -%>
      <%_ } -%>
      <%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
    const <%= field.relatedStructName.lowerCamelName %>: <%= field.relatedStructName.pascalName %>Entity = await this.<%= field.relatedStructName.lowerCamelName %>Repository.get(
      request.<%= field.name.lowerCamelName %>,
    );
    if (!<%= field.relatedStructName.lowerCamelName %>) {
      throw new Error('<%= field.name.lowerCamelName %> not found');
    }
    entity.<%= field.relatedStructName.lowerCamelName %> = <%= field.relatedStructName.lowerCamelName %>;
      <%_ } -%>
    <%_ }) -%>
    return entity;
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
