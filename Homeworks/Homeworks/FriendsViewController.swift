import UIKit

final class FriendsViewController: UITableViewController {
    
    private var networkService: NetworkService = NetworkService()
    
    private var friends: [FriendModel] = []
    
    private var dataService = FriendsDataService()
    
    let tableRefreshControl = UIRefreshControl()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Friends"
        label.textColor = ColorTheme.currentTheme.textColor
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableRefreshControl.attributedTitle = NSAttributedString(string: "Refreshing friends...")
        tableRefreshControl.addTarget(self, action: #selector(self.tableRefresh(_:)), for: .valueChanged)
        tableView.addSubview(tableRefreshControl)
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
        tableView.register(UserProfileCell.self, forCellReuseIdentifier: "cell")
        friends = dataService.getData()
        tableView.reloadData()
        self.navigationItem.title = "Friends"
        networkService.getFriends {[weak self] friends in
            self?.friends = friends
            self?.dataService.putData(friends: friends)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.tableView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        })
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.tableView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? UserProfileCell else {
            return UITableViewCell()
        }
        cell.click = { friend in
            let friendProfileViewController = FriendProfileViewController()
            friendProfileViewController.setFriendData(friendData: self.friends[indexPath.row] )
            self.navigationController?.pushViewController(friendProfileViewController, animated: true)
        }
        let user = friends[indexPath.row]
        cell.setCellConfiguration(userModel: user)
        cell.titleLabel.textColor = ColorTheme.currentTheme.textColor
        return cell
    }

    @objc func tableRefresh(_ sender: AnyObject){
        networkService.getFriends {[weak self] friends in
            self?.friends = friends
            self?.dataService.putData(friends: friends)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        tableRefreshControl.endRefreshing()
    }
}
