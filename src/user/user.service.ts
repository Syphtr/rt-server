import { Injectable, Inject, forwardRef } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { type User } from '@prisma/client';

@Injectable()
export class UserService {
  constructor(
    @Inject(forwardRef(() => PrismaService)) private prisma: PrismaService,
  ) {}

  async createUser(data: any): Promise<User> {
    return this.prisma.user.create({
      data,
    });
  }
}
