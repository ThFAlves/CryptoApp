import XCTest
@testable import CryptoApp

private final class DetailPresenterSpy: DetailPresenting {

    // MARK: - Variables
    var viewController: DetailDisplaying?
    
    enum Method: Equatable {
        case presentDetail(exchange: Exchange)
        case openWebsite(url: URL)
    }
    private(set) var calledMethods: [Method] = []

    // MARK: - Public Methods
    func presentDetail(exchange: Exchange) {
        calledMethods.append(.presentDetail(exchange: exchange))
    }
    
    func openWebsite(url: URL) {
        calledMethods.append(.openWebsite(url: url))
    }
}

final class DetailInteractorTests: XCTestCase {
    // MARK: - Variables
    private var presenterSpy = DetailPresenterSpy()
    
    private lazy var sut = DetailInteractor(presenter: presenterSpy, exchange: ExchangeMock.getMock())
    
    // MARK: - Public Methods
    func testLoadDetail() {
        sut.loadDetail()
        XCTAssertEqual(presenterSpy.calledMethods, [.presentDetail(exchange: ExchangeMock.getMock())])
    }
    
    func testLoadExchangeList_WhenResultIsSuccess_ShouldPresentData() {
        sut.openWebsite()
        XCTAssertEqual(presenterSpy.calledMethods, [.openWebsite(url: URL(string: "http://www.google.com")!)])
    }
}

