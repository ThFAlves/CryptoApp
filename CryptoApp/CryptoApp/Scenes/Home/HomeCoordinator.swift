import UIKit

enum HomeAction: Equatable {
    case detail(exchange: Exchange)
}

protocol HomeCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: HomeAction)
}

final class HomeCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - HomeCoordinating
extension HomeCoordinator: HomeCoordinating {
    func perform(action: HomeAction) {
        if case let .detail(exchange) = action {
            viewController?.navigationController?.pushViewController(DetailFactory.make(exchange: exchange), animated: true)
        }
    }
}
