import Foundation

protocol HomeInteracting: AnyObject {
    func loadExchangeList()
    func didSelectItem(row: Int)
}

final class HomeInteractor {
    private let service: HomeServicing
    private let presenter: HomePresenting
    var exchangeList: [Exchange] = []

    init(service: HomeServicing, presenter: HomePresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - HomeInteracting
extension HomeInteractor: HomeInteracting {
    func loadExchangeList() {
        presenter.presentStartLoading()
        service.getExchangeList { [weak self] result in
            self?.presenter.presentStopLoading()
            switch result {
            case let .success(exchangeList):
                self?.exchangeList = exchangeList
                self?.presenter.presentList(exchangeList: exchangeList)
            case let .failure(error):
                self?.presenter.presentError(apiError: error)
            }
        }
    }
    
    func didSelectItem(row: Int) {
        guard exchangeList.indices.contains(row) else {
            return
        }
        presenter.didNextStep(action: .detail(exchange: exchangeList[row]))
    }
}
