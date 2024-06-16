---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/handler/${struct.name.lowerSnakeName}/${struct.name.lowerSnakeName}.module.ts` : null %>"
force: true
---
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import UserEntity from 'src/entity/user.entity';
import {UserRepository} from "../../infrastructure/database/user.repository";

@Module({
  imports: [TypeOrmModule.forFeature([UserEntity])],
  controllers: [UserController],
  providers: [
    UserService,
    {
      provide: 'repository',
      useClass: UserRepository
    }
  ],
})
export class UserModule {}
