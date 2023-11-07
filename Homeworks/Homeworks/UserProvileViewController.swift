import UIKit

final class UserProfileViewController: UIViewController {
    
    private var networkService: NetworkService = NetworkService()
    
    private var userProfile: [FriendModel] = []
    
    private var darkThemeButton = UIButton()
    
    private var lightThemeButton = UIButton()
    
    private var pinkThemeButton = UIButton()
    
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
        setupButton(button: &darkThemeButton, label: "Dark theme")
        setupButton(button: &lightThemeButton, label: "Light theme")
        setupButton(button: &pinkThemeButton, label: "Pink theme")
        setupButtonsTarget()
        networkService.getUserProfile {[weak self] userProfile in
            self?.userProfile = userProfile
            DispatchQueue.main.async {
                self!.setUserProfileViewConfiguration(userModel: self?.userProfile.first ?? FriendModel(firstName: "", lastName: "", photoURL: ""))
                self?.view.reloadInputViews()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.reloadInputViews()
    }
    
    private func setupViews(){
        view.addSubview(userName)
        view.addSubview(userProfilePhoto)
        view.addSubview(darkThemeButton)
        view.addSubview(lightThemeButton)
        view.addSubview(pinkThemeButton)
    }
    
    private func setupConstraints(){
        userName.translatesAutoresizingMaskIntoConstraints = false
        userProfilePhoto.translatesAutoresizingMaskIntoConstraints = false
        darkThemeButton.translatesAutoresizingMaskIntoConstraints = false
        lightThemeButton.translatesAutoresizingMaskIntoConstraints = false
        pinkThemeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: userProfilePhoto.centerYAnchor),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width / 4),
            userName.heightAnchor.constraint(equalToConstant: 50),
            
            userProfilePhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width / 4),
            userProfilePhoto.widthAnchor.constraint(equalToConstant: 100),
            userProfilePhoto.heightAnchor.constraint(equalToConstant: 100),
            
            darkThemeButton.topAnchor.constraint(equalTo: userProfilePhoto.bottomAnchor, constant: 50),
            darkThemeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lightThemeButton.topAnchor.constraint(equalTo: darkThemeButton.bottomAnchor, constant: 50),
            lightThemeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pinkThemeButton.topAnchor.constraint(equalTo: lightThemeButton.bottomAnchor, constant: 50),
            pinkThemeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupButton(button: inout UIButton, label: String){
        button.setTitle(label, for: .normal)
        button.setTitleColor(ColorTheme.currentTheme.textColor, for: .normal)
        button.backgroundColor = .clear
    }
    
    private func setupButtonsTarget(){
        darkThemeButton.addTarget(self, action: #selector(clickOnButtonDark), for: .touchUpInside)
        lightThemeButton.addTarget(self, action: #selector(clickOnButtonLight), for: .touchUpInside)
        pinkThemeButton.addTarget(self, action: #selector(clickOnButtonPink), for: .touchUpInside)
    }
    
    private func setUserProfileViewConfiguration(userModel: FriendModel){
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
    
    @objc func clickOnButtonDark(){
        ColorTheme.currentTheme = DarkTheme()
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
    }
    
    @objc func clickOnButtonLight(){
        ColorTheme.currentTheme = LightTheme()
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
    }
    
    @objc func clickOnButtonPink(){
        ColorTheme.currentTheme = PinkTheme()
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
    }
}
