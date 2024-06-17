---
to: <%= rootDirectory %>/api/src/app.module.ts
force: true
---
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import {DatabaseModule} from "./database/database.module";
import * as Joi from '@hapi/joi';
// Add all modules import here

@Module({
  imports: [
    ConfigModule.forRoot({
      validationSchema: Joi.object({
        DATABASE_HOST: Joi.string().required(),
        DATABASE_PORT: Joi.number().required(),
        DATABASE_USER: Joi.string().required(),
        DATABASE_PASSWORD: Joi.string().required(),
        DATABASE_NAME: Joi.string().required(),
        PORT: Joi.number(),
      })
    }),
    DatabaseModule,
    // Add all modules here
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
