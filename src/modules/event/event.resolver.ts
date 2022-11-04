import {
  Artist,
  Event,
  EventCreateInput,
  EventUpdateInput,
  EventWhereInput,
  EventWhereUniqueInput,
  Venue,
} from "@generated/type-graphql";
import {
  Arg,
  FieldResolver,
  Mutation,
  Query,
  Resolver,
  Root,
} from "type-graphql";
import { prisma } from "../../infra/database";

@Resolver(of => Event)
export class EventResolver {
  @FieldResolver(returns => [Artist], { nullable: true })
  async artists(@Root() event: Event): Promise<Artist[]> {
    const data = await prisma.artistOnEvent.findMany({
      where: {
        eventId: event.id,
      },
      select: {
        artist: {
          include: {
            _count: true,
          },
        },
      },
    });

    return data?.map(artist => artist.artist);
  }

  @FieldResolver(returns => Venue, { nullable: true })
  async venue(@Root() event: Event): Promise<Venue | null> {
    return await prisma.event.findUnique({ where: { id: event.id } }).venue();
  }

  @Query(returns => Event, { nullable: true })
  async event(
    @Arg("where", type => EventWhereInput) where: EventWhereInput
  ): Promise<Event | null> {
    return await prisma.event.findFirst({
      where,
      include: {
        _count: {
          select: {
            artists: true,
          },
        },
      },
    });
  }

  @Mutation(returns => Event)
  async createEvent(
    @Arg("input", type => EventCreateInput) data: EventCreateInput
  ): Promise<Event> {
    const event = await prisma.event.create({ data });

    return event;
  }

  @Mutation(returns => Event, { nullable: true })
  async updateEvent(
    @Arg("where", type => EventWhereUniqueInput) where: EventWhereUniqueInput,
    @Arg("input", type => EventUpdateInput) data: EventUpdateInput
  ): Promise<Event> {
    const event = await prisma.event.update({ where, data });

    return event;
  }

  @Mutation(returns => Boolean)
  async deleteEvent(
    @Arg("where", type => EventWhereUniqueInput) where: EventWhereUniqueInput
  ): Promise<Boolean> {
    try {
      await prisma.artistOnEvent.deleteMany({ where: { eventId: where.id } });
      await prisma.event.delete({ where });

      return true;
    } catch {
      return false;
    }
  }
}
