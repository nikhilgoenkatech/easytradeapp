import {
    createLoadgen,
    createLoggerOptions,
    createBrowserContextPool,
    createBrowserOptions,
} from "@demoability/loadgen-core"
import { getConfig } from "./config"
import { getProvider } from "./provider"
import { Page } from "puppeteer"

async function main() {
    const config = getConfig()

    const provider = getProvider(config)
    const headless = config.headlessMode === "headless" ? "new" : false

    const browserPool = createBrowserContextPool({
        name: "main",
        browserOptions: createBrowserOptions({ headless, product: "chrome" }),
        loggerOptions: createLoggerOptions("browser", {
            logLevel: config.logLevel,
        }),
        browserTimeToLiveMs: config.browserTimeToLiveMinutes * 60_000,
        concurrentBrowsers: config.concurrent_browsers,
    })

    const loadgen = createLoadgen({
        visitProvider: provider,
        loggerOptions: createLoggerOptions("visit", {
            logLevel: config.logLevel,
        }),
        contextPool: browserPool,
        concurrency: config.concurrent_visits,
        initialPageSetup: async (page: Page) => {
            await page.setViewport({ width: 1920, height: 1080 })
        },
    })

    await loadgen.run()
}

main()
