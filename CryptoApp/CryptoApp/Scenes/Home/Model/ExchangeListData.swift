import Foundation

protocol ExchangeListDisplay { }

struct Exchange: Decodable, Equatable, ExchangeListDisplay {
    let exchangeId: String
    let website: String?
    let name: String?
    let volume1dayUsd: Double?
}
