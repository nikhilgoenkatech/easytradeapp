import {
    FunctionProviderWrapper,
    IProvider,
    IVisit,
    IntervalProviderWrapper,
    PriorityProviderWrapper,
    WeightedProvider,
} from "@demoability/loadgen-core"
import { Config } from "../config"
import { getRegularProviderFunction } from "./regularVisits"
import { getRareProviderFunction, getRareVisitInterval } from "./rareVisits"

export function getProvider(config: Config): IProvider<IVisit> {
    const regularVisitProvider = new WeightedProvider(
        config.regularVisitsWeights,
        getRegularProviderFunction(config)
    )
    const rareVisitsProvider = new IntervalProviderWrapper(
        new FunctionProviderWrapper(getRareProviderFunction(config)),
        getRareVisitInterval(config)
    )
    return new PriorityProviderWrapper([
        rareVisitsProvider,
        regularVisitProvider,
    ])
}
