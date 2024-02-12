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

import * as fs from 'fs/promises';
import * as path from 'path';

@Controller('import')
export class ImportsController {
  constructor(private readonly importsService: ImportsService) {}

  @Get('delete-all')
  async deleteAll() {
    return this.importsService.deleteAllTables();
  }

  @Get('find-all')
  async findAll() {
    return this.importsService.findAll();
  }

  @Get('hello')
  async hello() {
    return { msg: 'hello' };
  }

  @Get('read')
  async readFile() {
    const jsonFilePath = path.resolve(__dirname, '../../../profiles.json');

    // Read the JSON file
    const jsonData = await fs.readFile(jsonFilePath, 'utf-8');

    // Parse the JSON data
    const parsedData = JSON.parse(jsonData);

    return { data: parsedData };
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
