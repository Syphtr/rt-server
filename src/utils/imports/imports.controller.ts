import {
  Controller,
  Get,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { ImportsService } from './imports.service';
import { FileInterceptor } from '@nestjs/platform-express';
import { Express } from 'express';

@Controller('imports')
export class ImportsController {
  constructor(private readonly importsService: ImportsService) {}

  @Get('find-all')
  async findAll() {
    return this.importsService.findAll();
  }

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  uploadFile(@UploadedFile() file: Express.Multer.File) {
    const fileContent = file.buffer.toString('utf-8');

    try {
      const data = JSON.parse(fileContent);
      // Handle the parsed data (e.g., save to the database using Prisma)
      this.importsService.saveProfiles(data.results);

      return {
        success: true,
        message: 'File content parsed and processed successfully',
        data: data.results,
      };
    } catch (error) {
      console.error('Error parsing file content:', error);
      return { success: false, message: 'Error parsing file content' };
    }
  }
}
