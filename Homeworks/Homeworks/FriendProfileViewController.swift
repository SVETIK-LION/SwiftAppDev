import UIKit

final class FriendProfileViewController: UIViewController {
    
    private var networkService: NetworkService = NetworkService()
    
    private var userProfile: [FriendModel] = []
    
    private var userName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = ColorTheme.currentTheme.textColor
        label.textAlignment = .center
        return label
    }()
    
    private var userProfilePhoto = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
    }
    
    private func setupViews(){
        view.addSubview(userName)
        view.addSubview(userProfilePhoto)
        self.setFriendProfileViewConfiguration(userModel: userProfile.first!)
    }
    
    private func setupConstraints(){
        userName.translatesAutoresizingMaskIntoConstraints = false
        userProfilePhoto.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: userProfilePhoto.centerYAnchor),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width / 4),
            userName.heightAnchor.constraint(equalToConstant: 50),
            
            userProfilePhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width / 4),
            userProfilePhoto.widthAnchor.constraint(equalToConstant: 100),
            userProfilePhoto.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setFriendProfileViewConfiguration(userModel: FriendModel){
        userName.text = (userModel.firstName ?? "") + " " + (userModel.lastName ?? "")
        if let photoURL = userModel.photoURL,
           let url = URL(string: photoURL) {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    self.userProfilePhoto.image = UIImage(data: data)
                }
            }
        }
    }
    
    func setFriendData(friendData: FriendModel){
        self.userProfile.append(friendData)
    }
}
