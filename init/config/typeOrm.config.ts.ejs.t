---
to: <%= rootDirectory %>/api/src/config/typeOrm.config.ts
force: true
---
import { DataSource } from 'typeorm';
import { ConfigService } from '@nestjs/config';
import { config } from 'dotenv';
// Add all entities import here
import UserEntity from '../entity/user.entity';

config();

const configService = new ConfigService();

export default new DataSource({
  type: 'postgres',
  host: configService.get('DATABASE_HOST'),
  port: configService.get('DATABASE_PORT'),
  username: configService.get('DATABASE_USER'),
  password: configService.get('DATABASE_PASSWORD'),
  database: configService.get('DATABASE_NAME'),
  entities: [
    // Add all entities here
  ],
  migrations: ['./src/migrations/*.ts']
});