import "@testing-library/jest-dom"
import { screen, render } from "@testing-library/react"
import { FormatterWrapper } from "../providers"
import { Transaction } from "../../api/transaction/types"
import TransactionsTable from "../../components/TransactionsTable"
const mockTransactions: Transaction[] = [
    {
        id: 1,
        actionType: "SELL",
        instrumentName: "EasyHotels",
        amount: 8460,
        price: 23.17,
        status: "FAIL",
        endTime: "2023-03-20T12:15:00",
    },
    {
        id: 2,
        actionType: "BUY",
        instrumentName: "Charles - Mathieu",
        amount: 7,
        price: 3713.6,
        status: "FAIL",
        endTime: "2023-03-22T15:03:00",
    },
    {
        id: 3,
        actionType: "BUY",
        instrumentName: "Janssen Groep",
        amount: 234,
        price: 373.6,
        status: "FAIL",
        endTime: "2023-03-21T08:04:00",
    },
    {
        id: 4,
        actionType: "SELL",
        instrumentName: "BlueStar Craft",
        amount: 56,
        price: 1000.23,
        status: "FAIL",
        endTime: "2023-03-22T03:03:00",
    },
    {
        id: 5,
        actionType: "BUY",
        instrumentName: "Charles - Mathieu",
        amount: 10,
        price: 3713.6,
        status: "FAIL",
        endTime: "2023-03-21T20:03:00",
    },
]

describe("Transactions table", () => {
    test("displays full transaction data", async () => {
        render(
            <FormatterWrapper>
                <TransactionsTable
                    transactions={[mockTransactions[0]]}
                    instruments={[]}
                    disableVirtualization={true}
                />
            </FormatterWrapper>
        )

        expect(screen.getByRole("cell", { name: /sell/i })).toBeInTheDocument()
        expect(
            screen.getByRole("cell", { name: /easyhotels/i })
        ).toBeInTheDocument()
        expect(screen.getByRole("cell", { name: /8,460/ })).toBeInTheDocument()
        expect(screen.getByRole("cell", { name: /23.17/ })).toBeInTheDocument()
        expect(screen.getByRole("cell", { name: /fail/i })).toBeInTheDocument()
        expect(
            screen.getByRole("cell", {
                name: /3\/20\/23, 12:15 pm/i,
            })
        ).toBeInTheDocument()
    })
    test("displays all rows", async () => {
        render(
            <FormatterWrapper>
                <TransactionsTable
                    transactions={mockTransactions}
                    instruments={[]}
                    disableVirtualization={true}
                />
            </FormatterWrapper>
        )
        expect(screen.getAllByRole("row", { name: /fail/i })).toHaveLength(5)
    })
})
