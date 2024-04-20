import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { GraphQLModule } from "@nestjs/graphql";
import { ApolloDriver, ApolloDriverConfig } from "@nestjs/apollo";

import { controllers } from './controllers';
import { ServiceModule } from "./services";
import { ResolverModule } from "./resolvers";

const imports = [
    GraphQLModule.forRoot<ApolloDriverConfig>({
        driver: ApolloDriver,
        autoSchemaFile: 'schema.gql',
        sortSchema: true,
        subscriptions: {
            'graphql-ws': true
        },
    }),
    ServiceModule,
    ResolverModule,
    ConfigModule.forRoot({
        ignoreEnvFile: true
    })
]

@Module({
    imports,
    controllers,
})
export class AppModule { }
