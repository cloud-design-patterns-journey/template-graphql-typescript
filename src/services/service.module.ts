import {Module} from "@nestjs/common";

import {providers} from "./providers";
import { ConfigModule } from "@nestjs/config";

@Module({
    providers,
    exports: providers,
    imports: [ConfigModule]
})
export class ServiceModule {}
