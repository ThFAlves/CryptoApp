import UIKit

final class ExchangeCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExchangeCollectionViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = Colors.primary
        return label
    }()
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = Colors.secondary
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.secondary
        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(volumeLabel)
        stack.addArrangedSubview(idLabel)
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(info: ExchangeListDisplay) {
        guard let exchange = info as? Exchange else {
            return
        }
        let volume1Day = exchange.volume1dayUsd ?? 0
        nameLabel.text = exchange.name ?? ""
        volumeLabel.text = "Volume 1 Day: \(volume1Day)"
        idLabel.text = exchange.exchangeId
    }
}

extension ExchangeCollectionViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configureViews() {
        layer.cornerRadius = 16.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
    }
    
    func configureStyles() {
        backgroundColor = Colors.card
    }
}
