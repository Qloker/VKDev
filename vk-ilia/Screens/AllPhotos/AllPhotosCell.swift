
import UIKit
import SDWebImage
class AllPhotosCell: UICollectionViewCell {
    

    private var allPhotos: Photo?
    
    private let bcView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var photoForCell: UIImageView = {
       let photo = UIImageView()
        photo.contentMode = .scaleToFill
        photo.image = UIImage(named: "netflix")
       photo.translatesAutoresizingMaskIntoConstraints = false
       return photo
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
        addSubview(bcView)
        addSubview(photoForCell)
    }
}

extension AllPhotosCell {
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            photoForCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            photoForCell.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            photoForCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            photoForCell.widthAnchor.constraint(equalToConstant: 110),
            photoForCell.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
