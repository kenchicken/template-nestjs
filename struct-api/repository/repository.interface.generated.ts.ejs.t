---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/repository/${struct.name.lowerKebabName}.repository.interface.generated.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import { Search<%= struct.name.pascalName %>Condition } from 'src/app/dto/search-<%= struct.name.lowerKebabName %>.condition';

export abstract class <%= struct.name.pascalName %>RepositoryInterfaceGenerated {
  // 汎用検索系メソッド
  abstract getAll(condition: Search<%= struct.name.pascalName %>Condition): Promise<<%= struct.name.pascalName %>Entity[]>;
  abstract count(condition: Search<%= struct.name.pascalName %>Condition): Promise<number>;
  // CRUD系メソッド
  abstract get(id: number, option?: <%= struct.name.pascalName %>RelationOptions): Promise<<%= struct.name.pascalName %>Entity>;
  abstract create(<%= struct.name.pascalName %>: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
  abstract update(id: number, item: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
  abstract delete(id: number): Promise<void>;
}

export interface <%= struct.name.pascalName %>RelationOptions {
  all?: boolean;
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (field.relatedType === 'OneToMany') { -%>
  <%= field.name.lowerCamelName %>?: boolean;
  <%_ } -%>
  <%_ if (field.relatedType === 'ManyToOne') { -%>
  <%= field.name.lowerCamelName %>?: boolean;
  <%_ } -%>
<%_ }) -%>
}
