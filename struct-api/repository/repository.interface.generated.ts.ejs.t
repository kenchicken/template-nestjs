---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/repository/${struct.name.lowerKebabName}.repository.interface.generated.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Entity from "../entity/<%= ${struct.name.lowerKebabName} %>.entity";
import {<%= struct.name.pascalName %>SearchCondition} from "../module/<%= ${struct.name.lowerKebabName} %>/dto/search-<%= ${struct.name.lowerKebabName} %>.dto";

export abstract class <%= struct.name.pascalName %>RepositoryInterfaceGenerated {
  // query method
  abstract getAll(condition: <%= struct.name.pascalName %>SearchCondition): Promise<<%= struct.name.pascalName %>Entity[]>;
  abstract getAllWithCursor(condition: <%= struct.name.pascalName %>SearchCondition): Promise<<%= struct.name.pascalName %>Entity[]>;
  abstract count(condition: <%= struct.name.pascalName %>SearchCondition): Promise<number>;
  // crud method
  abstract get(id: number): Promise<<%= struct.name.pascalName %>Entity>;
  abstract getMulti(ids: number[]): Promise<<%= struct.name.pascalName %>Entity[]>;
  abstract create(<%= struct.name.lowerCamelName %>: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
  abstract update(id: string, item: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
  abstract delete(id: number): Promise<void>;
}