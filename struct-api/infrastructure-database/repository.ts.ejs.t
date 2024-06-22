---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/infrastructure/typeorm/${struct.name.lowerKebabName}.repository.ts` : null %>"
force: true
---
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import { <%= struct.name.pascalName %>RepositoryInterface } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface';

export class <%= struct.name.pascalName %>Repository implements <%= struct.name.pascalName %>RepositoryInterface {
  constructor(
    @InjectRepository(<%= struct.name.pascalName %>Entity)
    private <%= struct.name.lowerSnakeName %>Repository: Repository<<%= struct.name.pascalName %>Entity>,
  ) {}
}
