import { buildSchema } from "type-graphql";
import { ArtistResolver } from "../modules/artist/artist.resolver";
import { EventResolver } from "../modules/event/event.resolver";
import { UserResolver } from "../modules/user/user.resolver";
import {
  CreateOneTrackedArtistResolver,
  CreateManyTrackedArtistResolver,
  DeleteOneTrackedArtistResolver,
} from "@generated/type-graphql";

export const buildGqlSchema = async () => {
  return await buildSchema({
    resolvers: [
      DeleteOneTrackedArtistResolver,
      CreateOneTrackedArtistResolver,
      CreateManyTrackedArtistResolver,
      ArtistResolver,
      EventResolver,
      UserResolver,
    ],
    validate: false,
  });
};
