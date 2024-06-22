---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/repository/${struct.name.lowerKebabName}.repository.interface.generated.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';

export abstract class <%= struct.name.pascalName %>RepositoryInterfaceGenerated {
  // 汎用検索系メソッド
  abstract getAll(condition: <%= struct.name.pascalName %>SearchCondition): Promise<<%= struct.name.pascalName %>Entity[]>;
  abstract count(condition: <%= struct.name.pascalName %>SearchCondition): Promise<number>;
  abstract getAllWithCursor(condition: <%= struct.name.pascalName %>SearchCondition): Promise<<%= struct.name.pascalName %>Entity[]>;
  // CRUD系メソッド
  abstract get(id: number): Promise<<%= struct.name.pascalName %>Entity>;
  abstract getMulti(ids: number[]): Promise<<%= struct.name.pascalName %>Entity>;
  abstract create(<%= struct.name.pascalName %>: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
  abstract update(id: number, item: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
  abstract delete(id: number): Promise<void>;
}