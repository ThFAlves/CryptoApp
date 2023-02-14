import Foundation
import UIKit

protocol DetailPresenting: AnyObject {
    var viewController: DetailDisplaying? { get set }
    func presentDetail(exchange: Exchange)
    func openWebsite(url: URL)
}

final class DetailPresenter {
    weak var viewController: DetailDisplaying?
}

// MARK: - DetailPresenting
extension DetailPresenter: DetailPresenting {
    func presentDetail(exchange: Exchange) {
        viewController?.displayDetail(exchange: exchange)
    }
    
    func openWebsite(url: URL) {
        UIApplication.shared.open(url)
    }
}
