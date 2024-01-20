import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from '../utils/prisma/prisma.module';
import { ProfilesModule } from 'src/api/profiles/profiles.module';
import { ImportsModule } from 'src/utils/imports/imports.module';

@Module({
  imports: [PrismaModule, ProfilesModule, ImportsModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
