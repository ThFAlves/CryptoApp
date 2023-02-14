import Foundation

protocol HomePresenting: AnyObject {
    var viewController: HomeDisplaying? { get set }
    func didNextStep(action: HomeAction)
    func presentList(exchangeList: [Exchange])
    func presentError(apiError: ApiError)
    func presentStartLoading()
    func presentStopLoading()
}

final class HomePresenter {
    private let coordinator: HomeCoordinating
    weak var viewController: HomeDisplaying?

    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - HomePresenting
extension HomePresenter: HomePresenting {
    func didNextStep(action: HomeAction) {
        coordinator.perform(action: action)
    }
    
    func presentList(exchangeList: [Exchange]) {
        viewController?.displayList(exchangeList: exchangeList)
    }
    
    func presentError(apiError: ApiError) {
        viewController?.displayError(apiError: apiError)
    }
    
    func presentStartLoading() {
        viewController?.startLoading()
    }
    
    func presentStopLoading() {
        viewController?.stopLoading()
    }
}
