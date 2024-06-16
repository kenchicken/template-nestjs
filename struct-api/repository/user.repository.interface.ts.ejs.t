---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/repository/${struct.name.lowerSnakeName}.repository.interface.ts` : null %>"
force: true
---
import UserEntity from "../entity/user.entity";

export abstract class <%= struct.name.pascalName %>RepositoryInterface {
  abstract getAll(): Promise<<%= struct.name.pascalName %>Entity[]>;
  abstract get(id: string): Promise<<%= struct.name.pascalName %>Entity>;
  abstract create(<%= struct.name.lowerSnakeName %>: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
  abstract update(id: string, item: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
  abstract save(<%= struct.name.lowerSnakeName %>: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity>;
}