import { PrismaClient } from '@prisma/client';

import * as fs from 'fs/promises';

const prisma = new PrismaClient();

const jsonFilePath = './exampleData.json';

async function seedDatabase() {
  try {
    // Read the JSON file
    const jsonData = await fs.readFile(jsonFilePath, 'utf-8');

    // Parse the JSON data
    const parsedData = JSON.parse(jsonData);

    console.log(parsedData);

    // const profile = await prisma.profile.create({
    //   data: jsonData,
    // });

    // console.log('Database seeded successfully with profile id:', profile.id);
  } catch (error) {
    console.error('Error seeding database:', error);
  } finally {
    await prisma.$disconnect();
  }
}

seedDatabase();
