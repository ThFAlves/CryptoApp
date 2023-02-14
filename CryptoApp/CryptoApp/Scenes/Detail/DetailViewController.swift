import UIKit

protocol DetailDisplaying: AnyObject {
    func displayDetail(exchange: Exchange)
}

private extension DetailViewController.Layout {
    enum FontSize {
        static let big: CGFloat = 48
        static let medium: CGFloat = 24
    }
    enum Spacing {
        static let inset: CGFloat = 16
        static let stack: CGFloat = 16
    }
}

final class DetailViewController: ViewController<DetailInteracting, UIView> {
    fileprivate enum Layout { }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Layout.FontSize.big)
        label.textColor = Colors.primary
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Layout.FontSize.medium)
        label.textColor = Colors.secondary
        return label
    }()

    private lazy var webButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.brand
        button.setTitle("Abrir Website", for: .normal)
        button.addTarget(self, action: #selector(openWebSite), for: .touchUpInside)
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(idLabel)
        stack.addArrangedSubview(webButton)
        stack.spacing = Layout.Spacing.stack
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - View LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadDetail()
    }

    override func buildViewHierarchy() {
        view.addSubview(stack)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.Spacing.inset),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Spacing.inset),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.Spacing.inset)
        ])
        
        NSLayoutConstraint.activate([
            webButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    override func configureViews() {
        title = "Detalhe"
        view.backgroundColor = Colors.base
    }
    
    @objc
    private func openWebSite() {
        interactor.openWebsite()
    }
}

// MARK: - DetailDisplaying
extension DetailViewController: DetailDisplaying {
    func displayDetail(exchange: Exchange) {
        nameLabel.text = exchange.name ?? ""
        idLabel.text = exchange.exchangeId
        webButton.isHidden = exchange.website == nil
    }
}
