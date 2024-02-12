/*
  Warnings:

  - You are about to drop the column `category` on the `Company` table. All the data in the column will be lost.
  - You are about to drop the column `products` on the `Company` table. All the data in the column will be lost.
  - You are about to drop the column `strength` on the `Company` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name]` on the table `Company` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `targetMarketSize` to the `Company` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetVertical` to the `Company` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "CompanySize" AS ENUM ('SEED', 'STARTUP', 'SCALEUP', 'MID_SIZE', 'BIG', 'HUGE');

-- CreateEnum
CREATE TYPE "Stage" AS ENUM ('APPLIED', 'ADDED', 'SCREENING', 'SCREENED', 'FIRST_INTERVIEW', 'MID_INTERVIEWS', 'FINAL_INTERVIEW', 'HIRED');

-- AlterTable
ALTER TABLE "Company" DROP COLUMN "category",
DROP COLUMN "products",
DROP COLUMN "strength",
ADD COLUMN     "size" "CompanySize",
ADD COLUMN     "targetMarketSize" TEXT NOT NULL,
ADD COLUMN     "targetVertical" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "companyId" INTEGER NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompanyProductCategory" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "percentage" INTEGER NOT NULL,

    CONSTRAINT "CompanyProductCategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "name" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Job" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER,
    "department" TEXT,
    "businessUnit" TEXT,
    "hiringTeam" TEXT[],
    "title" TEXT,
    "salary" INTEGER,
    "currency" TEXT,
    "openSince" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "userId" INTEGER,

    CONSTRAINT "Job_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Client" (
    "id" SERIAL NOT NULL,
    "name" TEXT,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CandidateStage" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER,
    "jobId" INTEGER,
    "stage" "Stage",

    CONSTRAINT "CandidateStage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_JobCandidates" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Product_name_key" ON "Product"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CompanyProductCategory_companyId_productId_categoryId_key" ON "CompanyProductCategory"("companyId", "productId", "categoryId");

-- CreateIndex
CREATE UNIQUE INDEX "Client_name_key" ON "Client"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_JobCandidates_AB_unique" ON "_JobCandidates"("A", "B");

-- CreateIndex
CREATE INDEX "_JobCandidates_B_index" ON "_JobCandidates"("B");

-- CreateIndex
CREATE UNIQUE INDEX "Company_name_key" ON "Company"("name");

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyProductCategory" ADD CONSTRAINT "CompanyProductCategory_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyProductCategory" ADD CONSTRAINT "CompanyProductCategory_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyProductCategory" ADD CONSTRAINT "CompanyProductCategory_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateStage" ADD CONSTRAINT "CandidateStage_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateStage" ADD CONSTRAINT "CandidateStage_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_JobCandidates" ADD CONSTRAINT "_JobCandidates_A_fkey" FOREIGN KEY ("A") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_JobCandidates" ADD CONSTRAINT "_JobCandidates_B_fkey" FOREIGN KEY ("B") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;
