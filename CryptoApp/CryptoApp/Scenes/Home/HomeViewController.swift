import UIKit

protocol HomeDisplaying: AnyObject {
    func displayList(exchangeList: [Exchange])
    func displayError(apiError: ApiError)
    func startLoading()
    func stopLoading()
}

private extension HomeViewController.Layout {
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let itemHeight: CGFloat = 116
    }
    
    enum Section {
        case main
    }
}

final class HomeViewController: ViewController<HomeInteracting, UIView> {
    fileprivate enum Layout { }

    private lazy var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = .init(width: Layout.Size.screenWidth - 32, height: Layout.Size.itemHeight)
        flowLayout.minimumLineSpacing = 12
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.register(ExchangeCollectionViewCell.self, forCellWithReuseIdentifier: ExchangeCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var collectionViewDataSource: CollectionViewDataSource<Layout.Section, ExchangeListDisplay> = {
        let dataSource = CollectionViewDataSource<Layout.Section, ExchangeListDisplay>(view: collectionView)
        dataSource.itemProvider = { view, indexPath, item -> UICollectionViewCell? in
            let cell = view.dequeueReusableCell(withReuseIdentifier: ExchangeCollectionViewCell.identifier, for: indexPath) as? ExchangeCollectionViewCell
            cell?.setup(info: item)
            return cell
        }
        dataSource.add(section: .main)
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadExchangeList()
    }

    override func buildViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func configureViews() {
        title = "Exchanges"
        view.backgroundColor = Colors.base
        activityIndicator.color = Colors.brand
    }
}

// MARK: - HomeDisplaying
extension HomeViewController: HomeDisplaying {
    func displayList(exchangeList: [Exchange]) {
        collectionView.dataSource = collectionViewDataSource
        collectionViewDataSource.add(items: exchangeList, to: .main)
    }
    
    func displayError(apiError: ApiError) {
        let alert = UIAlertController(title: "Ops! Algo deu errado", message: apiError.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Tentar novamente", style: .default) { action in
            self.interactor.loadExchangeList()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func startLoading() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.removeFromSuperview()
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.didSelectItem(row: indexPath.row)
    }
}
