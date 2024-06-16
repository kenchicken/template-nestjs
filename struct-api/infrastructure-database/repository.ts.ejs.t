---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/infrastructure/database/${struct.name.lowerSnakeName}.repository.ts` : null %>"
force: true
---
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import UserEntity from 'src/entity/user.entity';

export class <%= struct.name.pascalName %>Repository extends Repository<<%= struct.name.pascalName %>Entity> {
  constructor(
    @InjectRepository(<%= struct.name.pascalName %>Entity)
    private <%= struct.name.lowerSnakeName %>Repository: Repository<<%= struct.name.pascalName %>Entity>
  ) {
    super(<%= struct.name.lowerSnakeName %>Repository.target, <%= struct.name.lowerSnakeName %>Repository.manager, <%= struct.name.lowerSnakeName %>Repository.queryRunner);
  }
}