import { EnvConfig } from "@demoability/loadgen-core"
import { Config, HEADLESS_MODES } from "./types"

export function getConfig(): Config {
    return {
        concurrent_visits: EnvConfig.getNumber("CONCURRENCY", 100),
        concurrent_browsers: EnvConfig.getNumber("BROWSERS", 1),
        browserTimeToLiveMinutes: EnvConfig.getNumber(
            "BROWSER_TTL_MINUTES",
            60
        ),
        logLevel: EnvConfig.getEnum(
            "LOG_LEVEL",
            ["silly", "debug", "verbose", "http", "info", "warn", "error"],
            "info"
        ),
        rareVisitsIntervalMinutes: EnvConfig.getNumber(
            "RARE_VISITS_INTERVAL_MINUTES",
            30
        ),
        headlessMode: EnvConfig.getEnum(
            "HEADLESS_MODE",
            HEADLESS_MODES,
            "headless"
        ),
        visitsConfig: {
            depositMinValue: EnvConfig.getNumber("DEPOSIT_MIN_VALUE", 500),
            depositMaxValue: EnvConfig.getNumber("DEPOSIT_MAX_VALUE", 1500),
            assetSellRatio: EnvConfig.getNumber("ASSET_SELL_RATIO", 0.1),
            withdrawMinValue: EnvConfig.getNumber("WITHDRAW_MIN_VALUE", 500),
            transactionMinDuration: EnvConfig.getNumber(
                "TRANSACTION_MIN_DURATION",
                1
            ),
            transactionMaxDuration: EnvConfig.getNumber(
                "TRANSACTION_MAX_DURATION",
                24
            ),
            easytradeUrl: EnvConfig.getUrl("EASYTRADE_URL"),
        },
        regularVisitsWeights: {
            deposit_and_buy_success: EnvConfig.getNumber(
                "DEPOSIT_AND_BUY_SUCCESS_WEIGHT",
                1
            ),
            deposit_and_long_buy_error: EnvConfig.getNumber(
                "DEPOSIT_AND_LONG_BUY_ERROR_WEIGHT",
                1
            ),
            deposit_and_long_buy_success: EnvConfig.getNumber(
                "DEPOSIT_AND_LONG_BUY_SUCCESS_WEIGHT",
                1
            ),
            deposit_and_long_buy_timeout: EnvConfig.getNumber(
                "DEPOSIT_AND_LONG_BUY_TIMEOUT_WEIGHT",
                1
            ),
            long_sell_error: EnvConfig.getNumber("LONG_SELL_ERROR_WEIGHT", 1),
            long_sell_success: EnvConfig.getNumber(
                "LONG_SELL_SUCCESS_WEIGHT",
                1
            ),
            long_sell_timeout: EnvConfig.getNumber(
                "LONG_SELL_TIMEOUT_WEIGHT",
                1
            ),
            sell_and_withdraw_success: EnvConfig.getNumber(
                "SELL_AND_WITHDRAW_SUCCESS_WEIGHT",
                1
            ),
        },
    }
}
