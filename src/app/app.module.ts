import { Module } from '@nestjs/common';

import { PrismaModule } from '../utils/prisma/prisma.module';
import { ProfilesModule } from 'src/api/profiles/profiles.module';
import { ImportsModule } from 'src/utils/imports/imports.module';

@Module({
  imports: [PrismaModule, ProfilesModule, ImportsModule],
})
export class AppModule {}
