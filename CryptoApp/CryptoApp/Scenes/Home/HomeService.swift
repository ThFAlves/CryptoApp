import Foundation

protocol HomeServicing {
    func getExchangeList(completion: @escaping CompletionExchangeData)
}

typealias CompletionExchangeData = (Result<[Exchange], ApiError>) -> Void

// MARK: - HomeServicing
final class HomeService: HomeServicing {
    func getExchangeList(completion: @escaping CompletionExchangeData) {
        Api<[Exchange]>(endpoint: ExchangeEndpoint.list).request { result in
            DispatchQueue.main.async {
                completion(result.map(\.model))
            }
        }
    }
}
