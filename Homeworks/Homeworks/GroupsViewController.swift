import UIKit

final class GroupsViewController: UITableViewController {
    
    private var networkService: NetworkService = NetworkService()
    
    private var groups: [GroupModel] = []
    
    private var dataService = GroupsDataService()
    
    private let tableRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableRefreshControl.attributedTitle = NSAttributedString(string: "Refreshig groups...")
        tableRefreshControl.addTarget(self, action: #selector(self.tableRefresh(_:)), for: .valueChanged)
        tableView.addSubview(tableRefreshControl)
        title = "Groups"
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
        tableView.backgroundColor = ColorTheme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .black
        tableView.register(GroupCell.self, forCellReuseIdentifier: "cell2")
        groups = dataService.getData()
        tableView.reloadData()
        networkService.getGroups{[weak self] groups in
            self?.groups = groups
            self?.dataService.putData(groups: groups)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = ColorTheme.currentTheme.backgroundColor
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        guard let cell = cell as? GroupCell else {
            return UITableViewCell()
        }
        let group = groups[indexPath.row]
        cell.setCellConfiguration(groupModel: group)
        cell.title.textColor = ColorTheme.currentTheme.textColor
        cell.subtitle.textColor = ColorTheme.currentTheme.textColor
        return cell
    }
    
    @objc func tableRefresh(_ sender: AnyObject){
        networkService.getGroups{[weak self] groups in
            self?.groups = groups
            self?.dataService.putData(groups: groups)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        tableRefreshControl.endRefreshing()
    }
}
