import Foundation

protocol DetailInteracting: AnyObject {
    func loadDetail()
    func openWebsite()
}

final class DetailInteractor {
    private let presenter: DetailPresenting
    private let exchange: Exchange

    init(presenter: DetailPresenting, exchange: Exchange) {
        self.presenter = presenter
        self.exchange = exchange
    }
}

// MARK: - DetailInteracting
extension DetailInteractor: DetailInteracting {
    func loadDetail() {
        presenter.presentDetail(exchange: exchange)
    }
    
    func openWebsite() {
        if let site = exchange.website, let url = URL(string: site) {
            presenter.openWebsite(url: url)
        }
    }
}
