import UIKit

enum DetailFactory {
    static func make(exchange: Exchange) -> DetailViewController {
        let presenter: DetailPresenting = DetailPresenter()
        let interactor = DetailInteractor(presenter: presenter, exchange: exchange)
        let viewController = DetailViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}
