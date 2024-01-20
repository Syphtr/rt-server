/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_authorId_fkey";

-- DropTable
DROP TABLE "Post";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Profile" (
    "id" SERIAL NOT NULL,
    "public_identifier" TEXT,
    "linkedin_profile_url" TEXT NOT NULL,
    "last_updated" TIMESTAMP(3),
    "first_name" TEXT,
    "last_name" TEXT,
    "full_name" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "country_full_name" TEXT,
    "summary" TEXT,
    "profile_pic_url" TEXT,
    "background_cover_image_url" TEXT,
    "headline" TEXT,
    "occupation" TEXT,
    "connections" INTEGER,
    "follower_count" INTEGER,
    "recommendations" TEXT[],
    "skills" TEXT[],

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Experience" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "company" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "location" TEXT,
    "starts_at" TIMESTAMP(3),
    "ends_at" TIMESTAMP(3),
    "company_linkedin_profile_url" TEXT,
    "logo_url" TEXT,

    CONSTRAINT "Experience_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Education" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "school" TEXT NOT NULL,
    "degree_name" TEXT NOT NULL,
    "field_of_study" TEXT,
    "starts_at" TIMESTAMP(3),
    "ends_at" TIMESTAMP(3),
    "description" TEXT,
    "activities_and_societies" TEXT,
    "grade" TEXT,
    "logo_url" TEXT,
    "school_linkedin_profile_url" TEXT,

    CONSTRAINT "Education_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Course" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "name" TEXT,
    "number" TEXT,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HonourAward" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "title" TEXT,
    "issuer" TEXT,
    "issuedOn" TIMESTAMP(3),
    "description" TEXT,

    CONSTRAINT "HonourAward_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccomplishmentOrg" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "orgName" TEXT,
    "title" TEXT,
    "description" TEXT,
    "startsAt" TIMESTAMP(3),
    "endsAt" TIMESTAMP(3),

    CONSTRAINT "AccomplishmentOrg_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Patent" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "title" TEXT,
    "issuer" TEXT,
    "issuedOn" TIMESTAMP(3),
    "description" TEXT,
    "applicationNumber" TEXT,
    "patentNumber" TEXT,
    "url" TEXT,

    CONSTRAINT "Patent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Project" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "title" TEXT,
    "description" TEXT,
    "url" TEXT,
    "startsAt" TIMESTAMP(3),
    "endsAt" TIMESTAMP(3),

    CONSTRAINT "Project_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Publication" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "name" TEXT,
    "publisher" TEXT,
    "publishedOn" TIMESTAMP(3),
    "description" TEXT,
    "url" TEXT,

    CONSTRAINT "Publication_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TestScore" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "name" TEXT,
    "score" TEXT,
    "dateOn" TIMESTAMP(3),
    "description" TEXT,

    CONSTRAINT "TestScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Activity" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "activityStatus" TEXT,
    "link" TEXT,
    "title" TEXT,

    CONSTRAINT "Activity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Article" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "title" TEXT,
    "link" TEXT,
    "publishedDate" TIMESTAMP(3),
    "author" TEXT,
    "imageUrl" TEXT,

    CONSTRAINT "Article_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Certification" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "authority" TEXT,
    "displaySource" TEXT,
    "endsAt" TIMESTAMP(3),
    "licenseNumber" TEXT,
    "name" TEXT,
    "startsAt" TIMESTAMP(3),
    "url" TEXT,

    CONSTRAINT "Certification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Group" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "profilePicUrl" TEXT,
    "name" TEXT,
    "url" TEXT,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VolunteerWork" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "cause" TEXT,
    "company" TEXT,
    "companyLinkedinProfileUrl" TEXT,
    "description" TEXT,
    "endsAt" TIMESTAMP(3),
    "logoUrl" TEXT,
    "startsAt" TIMESTAMP(3),
    "title" TEXT,

    CONSTRAINT "VolunteerWork_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PeopleAlsoViewed" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "link" TEXT,
    "name" TEXT,
    "summary" TEXT,
    "location" TEXT,

    CONSTRAINT "PeopleAlsoViewed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SimilarProfile" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "name" TEXT,
    "link" TEXT,
    "summary" TEXT,
    "location" TEXT,

    CONSTRAINT "SimilarProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Language" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "language" TEXT NOT NULL,

    CONSTRAINT "Language_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Company" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "products" TEXT,
    "category" TEXT,
    "strength" TEXT,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Profile_public_identifier_key" ON "Profile"("public_identifier");

-- AddForeignKey
ALTER TABLE "Experience" ADD CONSTRAINT "Experience_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Education" ADD CONSTRAINT "Education_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Course" ADD CONSTRAINT "Course_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HonourAward" ADD CONSTRAINT "HonourAward_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccomplishmentOrg" ADD CONSTRAINT "AccomplishmentOrg_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Patent" ADD CONSTRAINT "Patent_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Publication" ADD CONSTRAINT "Publication_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestScore" ADD CONSTRAINT "TestScore_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Activity" ADD CONSTRAINT "Activity_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Article" ADD CONSTRAINT "Article_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Certification" ADD CONSTRAINT "Certification_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Group" ADD CONSTRAINT "Group_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VolunteerWork" ADD CONSTRAINT "VolunteerWork_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeopleAlsoViewed" ADD CONSTRAINT "PeopleAlsoViewed_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SimilarProfile" ADD CONSTRAINT "SimilarProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Language" ADD CONSTRAINT "Language_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
