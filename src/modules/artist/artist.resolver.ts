import {
  Artist,
  ArtistCreateInput,
  ArtistUpdateInput,
  ArtistWhereInput,
  ArtistWhereUniqueInput,
  FindManyEventArgs,
  Event,
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

@Resolver(of => Artist)
export class ArtistResolver {
  @FieldResolver(returns => [Event], { nullable: true })
  async events(
    @Root() artist: Artist,
    @Args(type => FindManyEventArgs) args: FindManyEventArgs
  ): Promise<Event[] | null> {
    return await prisma.event.findMany({
      where: { ...args.where, artists: { some: { artistId: artist.id } } },
      ...args,
    });
  }

  @Query(returns => Artist, { nullable: true })
  async artist(
    @Arg("where", type => ArtistWhereInput) where: ArtistWhereInput
  ): Promise<Artist | null> {
    const artist = await prisma.artist.findFirst({
      where,
      include: {
        events: true,
        _count: true,
      },
    });

    return artist;
  }

  @Mutation(returns => Artist)
  async createArtist(
    @Arg("input", type => ArtistCreateInput) data: ArtistCreateInput
  ) {
    const artist = await prisma.artist.create({ data });

    return artist;
  }

  @Mutation(returns => Artist, { nullable: true })
  async updateArtist(
    @Arg("where", type => ArtistWhereUniqueInput) where: ArtistWhereUniqueInput,
    @Arg("input", type => ArtistUpdateInput) data: ArtistUpdateInput
  ) {
    const artist = await prisma.artist.update({ where, data });

    return artist;
  }
}
