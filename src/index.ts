import "reflect-metadata";
import "dotenv/config";
import { ApolloServer } from "@apollo/server";
import { startStandaloneServer } from "@apollo/server/standalone";
import { buildGqlSchema } from "./graphql/buildSchema";
import { prisma } from "./infra/database";

(async () => {
  const schema = await buildGqlSchema();
  const server = new ApolloServer({
    schema,
    introspection: true,
  });
  const { url } = await startStandaloneServer(server, {
    listen: {
      port: Number(process.env.PORT),
    },
    context: async () => {
      return {
        prisma,
      };
    },
  });

  console.log(`🚀 Server ready at ${url}`);
})();
