import XCTest
@testable import CryptoApp

private final class HomePresenterSpy: HomePresenting {
    // MARK: - Variables
    var viewController: HomeDisplaying?
    
    enum Method: Equatable {
        case presentList(exchangeList: [Exchange])
        case didNextStep(action: HomeAction)
        case presentError
        case presentStartLoading
        case presentStopLoading
    }
    private(set) var calledMethods: [Method] = []

    // MARK: - Public Methods
    func presentList(exchangeList: [Exchange]) {
        calledMethods.append(.presentList(exchangeList: exchangeList))
    }
    
    func didNextStep(action: HomeAction) {
        calledMethods.append(.didNextStep(action: action))
    }
    
    func presentError(apiError: ApiError) {
        calledMethods.append(.presentError)
    }
    
    func presentStartLoading() {
        calledMethods.append(.presentStartLoading)
    }
    
    func presentStopLoading() {
        calledMethods.append(.presentStopLoading)
    }
}

private final class HomeServiceSpy: HomeServicing {

    // MARK: - Variables
    private(set) var updateModelCalledCount = 0
    public var result: Result<[Exchange], ApiError>!
    
    // MARK: - Public Methods
    func getExchangeList(completion: @escaping CompletionExchangeData) {
        updateModelCalledCount += 1
        completion(result)
    }
}

final class HomeInteractorTests: XCTestCase {
    // MARK: - Variables
    private var presenterSpy = HomePresenterSpy()
    private let serviceSpy = HomeServiceSpy()
    
    private lazy var sut = HomeInteractor(service: serviceSpy, presenter: presenterSpy)
    
    // MARK: - Public Methods
    func testLoadExchangeList_WhenResultIsError_ShouldPresentError() {
        serviceSpy.result = .failure(.timeout)
        sut.loadExchangeList()
        XCTAssertEqual(presenterSpy.calledMethods, [.presentStartLoading, .presentStopLoading, .presentError])
    }
    
    func testLoadExchangeList_WhenResultIsSuccess_ShouldPresentData() {
        serviceSpy.result = .success([ExchangeMock.getMock()])
        sut.loadExchangeList()
        XCTAssertEqual(presenterSpy.calledMethods, [.presentStartLoading, .presentStopLoading, .presentList(exchangeList: [ExchangeMock.getMock()])])
    }
    
    func testDidSelectItem_WhenRacesIsEmpty_ShouldIgnoreSelect() {
        sut.didSelectItem(row: 0)
        XCTAssertEqual(presenterSpy.calledMethods, [])
    }
    
    func testDidSelectItem_WhenExchangeIsValidAndContains_ShouldCallAction() {
        sut.exchangeList = [ExchangeMock.getMock()]
        sut.didSelectItem(row: 0)
        XCTAssertEqual(presenterSpy.calledMethods, [.didNextStep(action: .detail(exchange: ExchangeMock.getMock()))])
    }
    
    func testDidSelectItem_WhenExchangeIndexNotContains_ShouldIgnoreAction() {
        sut.exchangeList = [ExchangeMock.getMock()]
        sut.didSelectItem(row: 20)
        XCTAssertEqual(presenterSpy.calledMethods, [])
    }
}
