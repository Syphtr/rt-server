import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

type ProfileOperation = {
  create?: Prisma.ProfileCreateInput;
  update?: {
    where: { public_identifier: string };
    data: Prisma.ProfileUpdateInput;
  };
};

@Injectable()
export class ImportsService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    try {
      const profiles = await this.prisma.profile.findMany({
        where: {},
        include: {
          education: true,
        },
      });

      return profiles;
    } catch (err) {
      console.log(err);
    }
  }

  async saveProfiles(selectedProfiles: any[]) {
    // const profilesToSave = Object.keys(selectedProfiles)
    //   .filter(
    //     (public_identifier: string) => selectedProfiles[public_identifier],
    //   )
    //   .map((public_identifier: string) => selectedProfiles[public_identifier])
    //   .filter(
    //     (
    //       data,
    //     ): data is {
    //       profile: Prisma.ProfileCreateInput;
    //       linkedin_profile_url: string;
    //       last_updated: string;
    //     } => data !== null,
    //   );

    const createProfileOperations: ProfileOperation[] = await Promise.all(
      selectedProfiles.map(async (data: any) => {
        const { profile } = data;

        // Clean up data before saving
        const cleanedProfile: Prisma.ProfileCreateInput = {
          linkedin_profile_url: data.linkedin_profile_url || '',
          last_updated: new Date(
            profile.last_updated
              ? profile.last_updated + 'Z'
              : '1970-01-01T00:00:00Z',
          ),
          public_identifier: profile.public_identifier || '',
          first_name: profile.first_name || '',
          last_name: profile.last_name || '',
          full_name: profile.full_name || '',
          city: profile.city || '',
          state: profile.state || '',
          country: profile.country || '',
          country_full_name: profile.country_full_name || '',
          summary: profile.summary || '',
          profile_pic_url: profile.profile_pic_url || '',
          background_cover_image_url: profile.background_cover_image_url || '',
          headline: profile.headline || '',
          occupation: profile.occupation || '',
          connections: profile.connections || 0,
          follower_count: profile.follower_count || 0,
          experiences: {
            create: Array.isArray(profile.experiences)
              ? profile.experiences.map((experience: any) => {
                  let startsAt: Date | null = null;
                  let endsAt: Date | null = null;

                  if (experience.starts_at) {
                    startsAt = new Date(
                      experience.starts_at.year,
                      experience.starts_at.month - 1,
                      experience.starts_at.day,
                    );
                  }

                  if (experience.ends_at) {
                    endsAt = new Date(
                      experience.ends_at.year,
                      experience.ends_at.month - 1,
                      experience.ends_at.day,
                    );
                  }

                  return {
                    company: experience.company || '',
                    title: experience.title || '',
                    description: experience.description || '',
                    location: experience.location || '',
                    starts_at: startsAt,
                    ends_at: endsAt,
                    company_linkedin_profile_url:
                      experience.company_linkedin_profile_url || '',
                    logo_url: experience.logo_url || '',
                  };
                })
              : [],
          },

          education: {
            create: Array.isArray(profile.education)
              ? profile.education.map((education: any) => {
                  let startsAt: Date | null = null;
                  let endsAt: Date | null = null;

                  if (education.starts_at) {
                    startsAt = new Date(
                      education.starts_at.year,
                      education.starts_at.month - 1,
                      education.starts_at.day,
                    );
                  }

                  if (education.ends_at) {
                    endsAt = new Date(
                      education.ends_at.year,
                      education.ends_at.month - 1,
                      education.ends_at.day,
                    );
                  }

                  console.log('Education Data:', {
                    school: education.school || '',
                    degree_name: education.degree_name || '',
                    field_of_study: education.field_of_study || '',
                    starts_at: startsAt,
                    ends_at: endsAt,
                    description: education.description || '',
                    activities_and_societies:
                      education.activities_and_societies || '',
                    grade: education.grade || '',
                    logo_url: education.logo_url || '',
                    school_linkedin_profile_url:
                      education.school_linkedin_profile_url || '',
                  });

                  return {
                    school: education.school || '',
                    degree_name: education.degree_name || '',
                    field_of_study: education.field_of_study || '',
                    starts_at: startsAt,
                    ends_at: endsAt,
                    description: education.description || '',
                    activities_and_societies:
                      education.activities_and_societies || '',
                    grade: education.grade || '',
                    logo_url: education.logo_url || '',
                    school_linkedin_profile_url:
                      education.school_linkedin_profile_url || '',
                  };
                })
              : [],
          },
          accomplishment_courses: {
            create: (profile.accomplishment_courses ||
              []) as Prisma.CourseCreateInput[],
          },
          accomplishment_honors_awards: {
            create: (
              (profile.accomplishment_honors_awards ||
                []) as Prisma.HonourAwardCreateInput[]
            ).map((award) => ({
              title: award.title || null,
              issuer: award.issuer || null,
              issuedOn: award.issuedOn || null,
              description: award.description || null,
            })),
          },
          accomplishment_organisations: {
            create: (
              (profile.accomplishment_organisations ||
                []) as Prisma.AccomplishmentOrgCreateInput[]
            ).map((org) => ({
              orgName: org.orgName || null,
              title: org.title || null,
              description: org.description || null,
              startsAt: org.startsAt || null,
              endsAt: org.endsAt || null,
            })),
          },

          accomplishment_patents: {
            create: (
              (profile.accomplishment_patents ||
                []) as Prisma.PatentCreateInput[]
            ).map((patent) => ({
              title: patent.title || null,
              issuer: patent.issuer || null,
              issuedOn: patent.issuedOn || null,
              description: patent.description || null,
              applicationNumber: patent.applicationNumber || null,
              patentNumber: patent.patentNumber || null,
              url: patent.url || null,
            })),
          },
          accomplishment_projects: {
            create: (Array.isArray(profile.accomplishment_projects)
              ? profile.accomplishment_projects
              : []
            ).map((project: any) => ({
              title: project?.title || null,
              description: project?.description || null,
              url: project?.url || null,
              startsAt: project?.startsAt ? new Date(project.startsAt) : null,
              endsAt: project?.endsAt ? new Date(project.endsAt) : null,
            })),
          },
          accomplishment_publications: {
            create: (
              (profile.accomplishment_publications ||
                []) as Prisma.PublicationCreateInput[]
            ).map((publication) => ({
              name: publication.name || null,
              publisher: publication.publisher || null,
              publishedOn: publication.publishedOn || null,
              description: publication.description || null,
              url: publication.url || null,
            })),
          },
          accomplishment_test_scores: {
            create: (Array.isArray(profile.accomplishment_test_scores)
              ? profile.accomplishment_test_scores
              : []
            ).map((testScore: any) => ({
              name: testScore?.name || null,
              score: testScore?.score || null,
              dateOn: testScore?.dateOn ? new Date(testScore.dateOn) : null,
              description: testScore?.description || null,
            })),
          },
          activities: {
            create: (
              (profile.activities || []) as Prisma.ActivityCreateInput[]
            ).map((activity) => ({
              activityStatus: activity.activityStatus || null,
              link: activity.link || null,
              title: activity.title || null,
            })),
          },
          articles: {
            create: (
              (profile.articles || []) as Prisma.ArticleCreateInput[]
            ).map((article) => ({
              title: article.title || null,
              link: article.link || null,
              publishedDate: article.publishedDate || null,
              author: article.author || null,
              imageUrl: article.imageUrl || null,
            })),
          },
          certifications: {
            create: (
              (profile.certifications ||
                []) as Prisma.CertificationCreateInput[]
            ).map(
              (certification) =>
                ({
                  authority: certification.authority || null,
                  displaySource: certification.displaySource || null,
                  endsAt: certification.endsAt || null,
                  licenseNumber: certification.licenseNumber || null,
                  name: certification.name || null,
                  startsAt: certification.startsAt || null,
                  url: certification.url || null,
                }) as Prisma.CertificationCreateInput,
            ),
          },
          groups: {
            create: ((profile.groups || []) as Prisma.GroupCreateInput[]).map(
              (group) =>
                ({
                  profilePicUrl: group.profilePicUrl || null,
                  name: group.name || null,
                  url: group.url || null,
                }) as Prisma.GroupCreateInput,
            ),
          },
          languages: {
            create: (
              (profile.languages || []) as Prisma.LanguageCreateInput[]
            ).map(
              (language) =>
                ({
                  language: language.language || 'default',
                }) as Prisma.LanguageCreateInput,
            ),
          },
          people_also_viewed: {
            create: (
              (profile.people_also_viewed ||
                []) as Prisma.PeopleAlsoViewedCreateInput[]
            ).map(
              (alsoViewed) =>
                ({
                  link: alsoViewed.link || null,
                  name: alsoViewed.name || null,
                  summary: alsoViewed.summary || null,
                  location: alsoViewed.location || null,
                }) as Prisma.PeopleAlsoViewedCreateInput,
            ),
          },
          recommendations: profile.recommendations || [],
          similarly_named_profiles: {
            create: (
              (profile.similarly_named_profiles ||
                []) as Prisma.SimilarProfileCreateInput[]
            ).map(
              (similarProfile) =>
                ({
                  name: similarProfile.name || null,
                  link: similarProfile.link || null,
                  summary: similarProfile.summary || null,
                  location: similarProfile.location || null,
                }) as Prisma.SimilarProfileCreateInput,
            ),
          },
          skills: profile.skills || [],
          volunteer_work: {
            create: (
              (profile.volunteer_work ||
                []) as Prisma.VolunteerWorkCreateInput[]
            ).map(
              (volunteerWork) =>
                ({
                  cause: volunteerWork.cause || null,
                  company: volunteerWork.company || null,
                  companyLinkedinProfileUrl:
                    volunteerWork.companyLinkedinProfileUrl || null,
                  description: volunteerWork.description || null,
                  endsAt: volunteerWork.endsAt || null,
                  logoUrl: volunteerWork.logoUrl || null,
                  startsAt: volunteerWork.startsAt || null,
                  title: volunteerWork.title || null,
                }) as Prisma.VolunteerWorkCreateInput,
            ),
          },
        };

        // Check if a profile with the given public_identifier already exists
        const existingProfile = await this.prisma.profile.findUnique({
          where: {
            public_identifier: profile.public_identifier,
          },
        });

        if (existingProfile) {
          // If the profile exists, return an update operation
          return {
            update: {
              where: { public_identifier: profile.public_identifier },
              data: cleanedProfile,
            },
          };
        } else {
          // If the profile doesn't exist, return a create operation
          console.log('FAILED');
          return { create: cleanedProfile };
        }
      }),
    );

    // Now, you can iterate through createProfileOperations and handle updates and creates separately
    for (const operation of createProfileOperations) {
      if (operation.create) {
        console.log('Executing Prisma Create Operation:', operation.create); // Log the operation data

        await this.prisma.profile.create({
          data: operation.create,
        });
      } else if (operation.update) {
        console.log('Executing Prisma Update Operation:', operation.update); // Log the operation data
        const { where, data } = operation.update;
        await this.prisma.profile.update({
          where,
          data,
        });
      }
    }
  }
}
