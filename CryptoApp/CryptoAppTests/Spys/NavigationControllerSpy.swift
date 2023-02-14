import UIKit

final class NavigationControllerSpy: UINavigationController {
    private(set) var pushedCount: Int = 0
    private(set) var presentCount: Int = 0
    private(set) var presentViewController: UIViewController?
    private(set) var currentViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        currentViewController = viewController
        pushedCount += 1
    }
}
