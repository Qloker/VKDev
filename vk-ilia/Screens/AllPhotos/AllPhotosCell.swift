//
//  AllPhotosCell.swift
//  vk-ilia
//
//  Created by Ilia Zakharov on 28.05.2022.
//

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

    //MARK: - Public
    
    //wildcard
//    func configure(_ friend: Friend) {
//
//        self.friend = friend
//
//        firstNameLabel.text = "\(friend.firstName ?? "")"
//        secondNameLabel.text = "\(friend.lastName ?? "")"
//        cityLabel.text = "\(friend.city?.title ?? "")"
//    }
//
    
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
    
  //   передача на VC
//    func allPhotoConfig(_ group: Group) {
//
//        self.allPhotos = allPhotos
//
//
//        let photoGroupUrl = URL(string: group.photo200)
//        groupPhotoView.sd_setImage(with: photoGroupUrl, placeholderImage: UIImage(named: "netflix"))
////        let photoUrl = URL(string: photo.sizes?.first?.url ?? "")
////
////        cell.photoView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "default"))
//
//    }
    
}

extension AllPhotosCell {
    
    private func setConstraints() {

//        NSLayoutConstraint.activate([
//            bcView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//            bcView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//            bcView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
//            bcView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
//        ])

        
        NSLayoutConstraint.activate([
            photoForCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            photoForCell.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            photoForCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            photoForCell.widthAnchor.constraint(equalToConstant: 110),
            photoForCell.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
