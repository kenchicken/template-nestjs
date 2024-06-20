---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/repository/${struct.name.lowerKebabName}.repository.interface.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Entity from "../entity/<%= struct.name.lowerKebabName %>.entity";

// add repository input/output parameter

export abstract class <%= struct.name.pascalName %>RepositoryInterface {
  // add repository method here
}