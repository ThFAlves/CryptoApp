import Foundation

enum ExchangeEndpoint {
    case list
    case detail(exchangeId: String)
}

extension ExchangeEndpoint: ApiEndpoint {
    var path: String {
        switch self {
        case .list:
            return "v1/exchanges"
        case let .detail(exchangeId):
            return "v1/exchanges/\(exchangeId)"
        }
    }
    
    var customHeaders: [String : String] {
        ["Accept": "application/json",
         "X-CoinAPI-Key": "562B9842-1F2F-4A92-BC0F-8879464C8700"]
    }
}
