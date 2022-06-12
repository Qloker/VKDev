
import UIKit
import SDWebImage
final class GroupsCollectionViewCell: UICollectionViewCell {

    private var group: Group?
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3156948984, green: 0.5965610147, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var groupPhotoView: UIImageView = {
       let photo = UIImageView()
       photo.contentMode = .scaleAspectFit
        photo.image = UIImage(named: "netflix")
       photo.translatesAutoresizingMaskIntoConstraints = false
       return photo
   }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Name"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let screenNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "SecondName"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "City"
        label.textColor = .green
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - Actions
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        addSubview(backgroundCell)

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(screenNameLabel)
        
        addSubview(groupPhotoView)
        addSubview(stackView)
        addSubview(itemDescriptionLabel)
        
    }

    func groupConfig(_ group: Group) {
        
        self.group = group
        
        nameLabel.text = "\(group.name)"
        screenNameLabel.text = "\(group.screenName)"
        itemDescriptionLabel.text = "\(group.itemDescription)"
        
        let photoGroupUrl = URL(string: group.photo200)
        groupPhotoView.sd_setImage(with: photoGroupUrl, placeholderImage: UIImage(named: "netflix"))
        
    }
    
}

extension GroupsCollectionViewCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            groupPhotoView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 5),
            groupPhotoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            groupPhotoView.widthAnchor.constraint(equalToConstant: 100),
            groupPhotoView.heightAnchor.constraint(equalToConstant: 100),
            
        
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: groupPhotoView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: groupPhotoView.trailingAnchor, constant: 10),
            itemDescriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    
    }

}
