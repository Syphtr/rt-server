import { NestFactory } from '@nestjs/core';
import { AppModule } from './app/app.module';
// const port = process.env.PORT || 5001;

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  await app.listen('0.0.0.0');
}
bootstrap();
