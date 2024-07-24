---
to: <%= rootDirectory %>/api/src/app/config/typeOrm.config.ts
force: true
---
import { DataSource } from 'typeorm';
import { ConfigService } from '@nestjs/config';
import { config } from 'dotenv';
// add import entity

config();

const configService = new ConfigService();

const AppDataSource = new DataSource({
  type: 'postgres',
  host: configService.get('DATABASE_HOST'),
  port: configService.get('DATABASE_PORT'),
  username: configService.get('DATABASE_USER'),
  password: configService.get('DATABASE_PASSWORD'),
  database: configService.get('DATABASE_NAME'),
  // migration対象をここで管理する
  entities: [
    // add entity after here
  ],
  migrationsTableName: 'app_migrations',
  migrations: ['./src/database/migrations/*.ts'],
});
AppDataSource.initialize();

export default AppDataSource;