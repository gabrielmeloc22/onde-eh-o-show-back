import {
  Artist,
  Config,
  FindManyArtistArgs,
  User,
  UserCreateInput,
  UserUpdateInput,
  UserWhereInput,
  UserWhereUniqueInput,
} from "@generated/type-graphql";
import {
  Arg,
  Args,
  FieldResolver,
  Mutation,
  Query,
  Resolver,
  Root,
} from "type-graphql";
import { prisma } from "../../infra/database";

@Resolver(of => User)
export class UserResolver {
  async config(@Root() user: User): Promise<Config | null> {
    const config = await prisma.user
      .findUnique({ where: { id: user.id } })
      .config();

    return config;
  }

  @FieldResolver(returns => [Artist], { nullable: true })
  async trackedArtists(
    @Root() user: User,
    @Args(type => FindManyArtistArgs)
    artistArgs: FindManyArtistArgs
  ): Promise<Artist[]> {
    const trackedArtists = await prisma.artist.findMany({
      where: {
        trackings: {
          some: {
            userId: user.spotifyId,
          },
        },
      },
      ...artistArgs,
    });

    return trackedArtists;
  }

  @Query(returns => User, { nullable: true })
  async user(
    @Arg("where", type => UserWhereInput) where: UserWhereInput
  ): Promise<User | null> {
    return await prisma.user.findFirst({
      where,
      include: {
        _count: true,
      },
    });
  }

  @Mutation(returns => User)
  async updateUser(
    @Arg("where", type => UserWhereUniqueInput) where: UserWhereUniqueInput,
    @Arg("data", type => UserUpdateInput) data: UserUpdateInput
  ): Promise<User | null> {
    return prisma.user.update({ where, data });
  }

  @Mutation(returns => User)
  async createUser(
    @Arg("data", type => UserCreateInput) data: UserCreateInput
  ): Promise<User> {
    return await prisma.user.create({
      data: {
        ...data,
        config: {
          create: new Config(),
        },
      },
    });
  }

  @Mutation(returns => Boolean)
  async deleteUser(
    @Arg("where", type => UserWhereUniqueInput) where: UserWhereUniqueInput
  ): Promise<boolean> {
    try {
      const user = await prisma.user.findUnique({ where });

      await prisma.config.delete({
        where: {
          userId: user?.id,
        },
      });

      await prisma.trackedArtist.deleteMany({
        where: {
          userId: where.id,
          user: {
            spotifyId: where.spotifyId,
          },
        },
      });
      await prisma.user.delete({ where });

      return true;
    } catch (e) {
      console.log(e);
      return false;
    }
  }
}
