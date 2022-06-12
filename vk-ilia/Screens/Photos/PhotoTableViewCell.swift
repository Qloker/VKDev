//
//  FriendTableView.swift
//  vk-ilia
//
//  Created by Ilia Zakharov on 06.05.2022.
//

import Foundation
import UIKit


class PhotoTableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.7841508985, green: 0.8082179427, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     var photoView: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFit
        photo.image = UIImage(named: "netflix")
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6534121037, green: 0.4303875566, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var photoNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "Photo N1"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
   private func setupViews() {

       backgroundColor = .clear
       selectionStyle = .none
       
       addSubview(backgroundCell)
       addSubview(photoView)
       addSubview(lineView)
       addSubview(photoNumberLabel)
    }
    
    private func cellConfig(number: Int) {
        photoNumberLabel.text = "Photo №\(number)"
    }
    
    public func setCellConfig(number: Int) {
        cellConfig(number: number)
    }
    
}

extension PhotoTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            photoView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            photoView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 20),
            photoView.heightAnchor.constraint(equalToConstant: 100),
            photoView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            photoNumberLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            photoNumberLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 5),
        
        ])
        
        // при скроле наверх не отображается
//        NSLayoutConstraint.activate([
//            lineView.topAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: 0),
//            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
//            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
//            lineView.heightAnchor.constraint(equalToConstant: 3)
//
//        ])
    }
    
}
