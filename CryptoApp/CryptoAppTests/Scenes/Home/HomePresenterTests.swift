import XCTest
@testable import CryptoApp

private final class HomeCoordinatorSpy: HomeCoordinating {
    
    // MARK: - Variables
    var viewController: UIViewController?
    
    private(set) var action = [HomeAction]()

    // MARK: - Public Methods
    func perform(action: HomeAction) {
        self.action.append(action)
    }
}

final class HomeViewControllerSpy: HomeDisplaying {

    // MARK: - Variables
    enum Method: Equatable {
        case displayList(exchangeList: [Exchange])
        case displayError
        case startLoading
        case stopLoading
    }
    private(set) var calledMethods: [Method] = []
    
    func displayList(exchangeList: [Exchange]) {
        calledMethods.append(.displayList(exchangeList: exchangeList))
    }
    
    func displayError(apiError: ApiError) {
        calledMethods.append(.displayError)
    }
    
    func startLoading() {
        calledMethods.append(.startLoading)
    }
    
    func stopLoading() {
        calledMethods.append(.stopLoading)
    }
}

final class HomePresenterTests: XCTestCase {
    // MARK: - Variables
    private var coordinatorSpy = HomeCoordinatorSpy()
    private let viewControllerSpy = HomeViewControllerSpy()
    
    private lazy var sut: HomePresenter = {
        let sut = HomePresenter(coordinator: coordinatorSpy)
        sut.viewController = viewControllerSpy
        return sut
    }()
    
    // MARK: - Public Methods
    func testDidNextStep_WhenSelectDetail_ShouldOpenDetail() {
        let exchange = ExchangeMock.getMock()
        sut.didNextStep(action: .detail(exchange: exchange))
        XCTAssertEqual(coordinatorSpy.action, [.detail(exchange: exchange)])
    }
    
    func testPresentError_WhenReceiveTimeout_ShouldPresentError() {
        sut.presentError(apiError: .timeout)
        XCTAssertEqual(viewControllerSpy.calledMethods, [.displayError])
    }
    
    func testPresentRaces_WhenReceiveEmptyRaces_ShouldPresentRaces() {
        sut.presentList(exchangeList: [ExchangeMock.getMock()])
        XCTAssertEqual(viewControllerSpy.calledMethods, [.displayList(exchangeList: [ExchangeMock.getMock()])])
    }
    
    func testPresentStartLoading_WhenStartLoading_ShouldPresentLoading() {
        sut.presentStartLoading()
        XCTAssertEqual(viewControllerSpy.calledMethods, [.startLoading])
    }
    
    func testPresentStopLoading_WhenStopLoading_WhenPresentStopLoading() {
        sut.presentStopLoading()
        XCTAssertEqual(viewControllerSpy.calledMethods, [.stopLoading])
    }
}
