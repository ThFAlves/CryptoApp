import XCTest
@testable import CryptoApp

final class HomeCoordinatorTests: XCTestCase {
    // MARK: - Variables
    private let viewControllerSpy = ViewControllerSpy()
    private lazy var navigationSpy = NavigationControllerSpy(rootViewController: viewControllerSpy)
    
    private lazy var sut: HomeCoordinator = {
        let sut = HomeCoordinator()
        sut.viewController = navigationSpy.topViewController
        return sut
    }()
    
    // MARK: - Public Methods
    func testPerform_WhenDetail_ShouldPresentScren() {
        sut.perform(action: .detail(exchange: ExchangeMock.getMock()))
        XCTAssertEqual(navigationSpy.pushedCount, 2)
    }
}
