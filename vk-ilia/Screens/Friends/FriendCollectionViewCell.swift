
import UIKit

final class FriendCollectionViewCell: UICollectionViewCell {
    
    var onGroupTapAction: ( (Int)->() )?
    var onPhotoTapAction: ( (Int)->() )?
    
    private var friend: Friend?
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3156948984, green: 0.5965610147, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Name"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "SecondName"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "City"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var groupsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Groups", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6951998472, blue: 0.6691294312, alpha: 1)
        button.addTarget(self, action: #selector(groupsTappedAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var photosButton: UIButton = {
        let button = UIButton()
        button.setTitle("Photos", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6951998472, blue: 0.6691294312, alpha: 1)
        button.addTarget(self, action: #selector(photosTappedAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let friendPhotoView: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(named: "netflix")
        photo.contentMode = .scaleAspectFit
        photo.layer.cornerRadius = 20
        photo.layer.masksToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
   
    
    //MARK: - Public
    
    func configure(_ friend: Friend) {
        
        self.friend = friend
        
        firstNameLabel.text = "\(friend.firstName ?? "")"
        secondNameLabel.text = "\(friend.lastName ?? "")"
        cityLabel.text = "\(friend.city?.title ?? "")"
        
        let friendPhotoUrl = URL(string: friend.photo50 ?? "")
        friendPhotoView.sd_setImage(with: friendPhotoUrl, placeholderImage: UIImage(named: "netflix"))
    }
    
    
    //MARK: - Actions
    @objc private func groupsTappedAction() {
        print("TAPPED GROUPS!!!")
        
        onGroupTapAction?(friend?.id ?? 0)

    }
    
    @objc private func photosTappedAction() {
        print("TAPPED PHOTOS!!!")
        
        onPhotoTapAction?(friend?.id ?? 0)
    }
    
   
    
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
        
        addSubview(friendPhotoView)
        stackView.addArrangedSubview(firstNameLabel)
        stackView.addArrangedSubview(secondNameLabel)
        
        addSubview(stackView)
        addSubview(cityLabel)
        addSubview(groupsButton)
        addSubview(photosButton)
    
    }
    
}

extension FriendCollectionViewCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            friendPhotoView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 5),
            friendPhotoView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            friendPhotoView.widthAnchor.constraint(equalToConstant: 100),
            friendPhotoView.heightAnchor.constraint(equalToConstant: 100)
        
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: friendPhotoView.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            cityLabel.leadingAnchor.constraint(equalTo: friendPhotoView.trailingAnchor, constant: 10)
        
        ])
        
        NSLayoutConstraint.activate([
            groupsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            groupsButton.leadingAnchor.constraint(equalTo: friendPhotoView.trailingAnchor, constant: 15),
            groupsButton.heightAnchor.constraint(equalToConstant: 40),
            groupsButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            photosButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            photosButton.leadingAnchor.constraint(equalTo: groupsButton.trailingAnchor, constant: 15),
            photosButton.heightAnchor.constraint(equalToConstant: 40),
            photosButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
