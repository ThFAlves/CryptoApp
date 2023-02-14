import Foundation
@testable import CryptoApp

final class ExchangeMock {
    static func getMock() -> Exchange {
        Exchange(exchangeId: "exchange_id",
                 website: "http://www.google.com",
                 name: "Exchange",
                 volume1dayUsd: 151.94)
    }
}
