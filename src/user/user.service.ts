import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { type User } from '@prisma/client';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async createUser(data: any): Promise<User> {
    return this.prisma.user.create({
      data,
    });
  }
}
