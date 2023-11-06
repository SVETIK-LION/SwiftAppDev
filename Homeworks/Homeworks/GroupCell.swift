import UIKit

final class GroupCell: UITableViewCell {
    
    private var groupImageView = UIImageView(image: UIImage(systemName: "person"))
    
    var title: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = ColorTheme.currentTheme.textColor
        return label
    }()

    var subtitle: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = ColorTheme.currentTheme.textColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
    
    private func setupViews() {
        contentView.addSubview(groupImageView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        setupConstraints()
    }
    
    private func setupConstraints() {
        groupImageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            groupImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            groupImageView.heightAnchor.constraint(equalToConstant: 50),
            groupImageView.widthAnchor.constraint(equalTo: groupImageView.heightAnchor),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: groupImageView.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setCellConfiguration(groupModel: GroupModel){
        title.text = groupModel.name ?? "error"
        subtitle.text = groupModel.description ?? "error"
        if let photoURL = groupModel.photoURL,
           let url = URL(string: photoURL) {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    self.groupImageView.image = UIImage(data: data)
                }
            }
        }
    }
}
