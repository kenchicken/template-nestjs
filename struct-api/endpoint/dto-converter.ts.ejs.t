---
to: "<%= !struct.excludeGenerateAPI.get ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/dto-converter.ts` : null %>"
force: true
---
import ObjectUtil from 'src/app/util/object-util';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import Model<%= struct.name.pascalName %> from 'src/app/dto/model-<%= struct.name.lowerKebabName %>';
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

export const convertEntityToResponse = async (
  entity: <%= struct.name.pascalName %>Entity,
): Promise<Model<%= struct.name.pascalName %>> => {
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
  response.<%= field.relatedStructName.lowerCamelName %>ID = <%= field.relatedStructName.lowerCamelName %>Model.id;
    <%_ } -%>
  <%_ }) -%>
  return response;
};
