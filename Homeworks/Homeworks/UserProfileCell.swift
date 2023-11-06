import UIKit

final class UserProfileCell: UITableViewCell {
    
    var userImage = UIImageView(image: UIImage(systemName: "person"))
    
    var tableView = UITableView()
    
    var click: ((UITableView) -> Void)?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = ColorTheme.currentTheme.textColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(clickOnCell))
        addGestureRecognizer(recognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
    
    private func setupViews(){
        contentView.addSubview(userImage)
        contentView.addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints(){
        userImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userImage.widthAnchor.constraint(equalToConstant: frame.size.width / 5),
            userImage.heightAnchor.constraint(equalToConstant: frame.size.height / 1),
            
            titleLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    @objc func clickOnCell(){
        click?(tableView)
    }
    
    func setCellConfiguration(userModel: FriendModel){
        titleLabel.text = (userModel.firstName ?? "") + " " + (userModel.lastName ?? "")
        if let photoURL = userModel.photoURL,
           let url = URL(string: photoURL) {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    self.userImage.image = UIImage(data: data)
                }
            }
        }
    }
}
