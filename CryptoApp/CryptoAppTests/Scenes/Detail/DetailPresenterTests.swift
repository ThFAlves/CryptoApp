import XCTest
@testable import CryptoApp

final class DetailViewControllerSpy: DetailDisplaying {

    // MARK: - Variables
    enum Method: Equatable {
        case displayList(exchange: Exchange)
    }
    private(set) var calledMethods: [Method] = []
    
    func displayDetail(exchange: Exchange) {
        calledMethods.append(.displayList(exchange: exchange))
    }
}

final class DetailPresenterTests: XCTestCase {
    // MARK: - Variables
    private let viewControllerSpy = DetailViewControllerSpy()
    
    private lazy var sut: DetailPresenter = {
        let sut = DetailPresenter()
        sut.viewController = viewControllerSpy
        return sut
    }()
    
    // MARK: - Public Methods
    func testPresentDetail_WhenReceiveExchangeObject() {
        sut.presentDetail(exchange: ExchangeMock.getMock())
        XCTAssertEqual(viewControllerSpy.calledMethods, [.displayList(exchange: ExchangeMock.getMock())])
    }
}
