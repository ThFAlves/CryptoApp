import Foundation

class ReloadableDataSource<View: AnyObject & ReloadableView, Cell, Section: Hashable, Item>: NSObject, Reloadable {
    weak var reloadableView: View?
    var automaticReloadData = true
    
    // MARK: Aliases
    typealias ItemProvider = (_ view: View, _ indexPath: IndexPath, _ item: Item) -> Cell?
    
    // MARK: - Data
    private(set) var sections: [Section] = []
    private(set) var data: [Section: [Item]] = [:] {
        didSet {
            guard automaticReloadData else { return }
            reloadableView?.reloadData()
        }
    }
    
    // MARK: - Providers
    var itemProvider: ItemProvider?
    
    // MARK: - Initializer
    init(view: View, itemProvider: ItemProvider? = nil) {
        super.init()
        self.reloadableView = view
        self.itemProvider = itemProvider
    }
    
    // MARK: - Data management
    func add(section: Section) {
        if !sections.contains(section) {
            sections.append(section)
            data[section] = []
        }
    }
    
    func add(items: [Item], to section: Section) {
        add(section: section)
        var currentItems = data[section, default: []]
        currentItems.append(contentsOf: items)
        data[section] = currentItems
    }
    
    func update(items: [Item], from section: Section) {
        if sections.contains(section) {
            data[section] = items
        }
    }
    
    func remove(section: Section) {
        sections.removeAll(where: { $0.hashValue == section.hashValue })
        data.removeValue(forKey: section)
    }

    func sort(sections sortCompletion: (Section, Section) throws -> Bool) throws {
        try sections.sort(by: sortCompletion)
    }
    
    func item(at indexPath: IndexPath) -> Item? {
        data[sections[indexPath.section]]?[indexPath.row]
    }
}
