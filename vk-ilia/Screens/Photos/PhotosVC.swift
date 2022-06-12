//
//  PhotosViewController.swift
//  vk-app
//
//  Created by Ilia Zakharov on 28.04.2022.
//

import Foundation
import UIKit
import SDWebImage

class PhotosVC: UIViewController {
    
    let photosAPI = PhotosAPI()
    
    var userId: Int = 0
    var photos: [Photo] = []
    
    //Основной способ создания UI контролов - если нет кастомных классов под это дело
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        return tableView
//    }()
    
    private let myTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = #colorLiteral(red: 1, green: 0.9961672425, blue: 0.832010746, alpha: 1)
        tableView.separatorStyle = .none                                  // убирает разделители между ячейками
        tableView.bounces = false                                         // убирает оттягивание таблицы вниз
        tableView.showsVerticalScrollIndicator = false                    // убирает ползунок
        tableView.delaysContentTouches = false                            // убирает приоритет скрола у таблицы
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let idTableView = "idTableView"
    
//    //Передача через инициализтор - способ 1 (основной)
//    init(userId: Int) {
//        self.userId = userId
//        
//        //Designated initializer - вызвать родительский инициализатор
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    private let photoLabel: UILabel = {
        let view = UILabel()
        view.text = "Photos"
        view.font = UIFont.systemFont(ofSize: 24)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        
        setupViews()
        setupConstraints()
        setDelegates()
        
        photosAPI.getPhotos(userId: userId) { photos in
            //print(photos)
            self.photos = photos
            self.myTableView.reloadData()
            
//            for photo in photos {
//                print(photo.sizes?.first?.url)
//            }
        }
        print(photos.count)
    }
    
    //MARK: - Private methods
    private func setupViews() {
        view.backgroundColor = .white
        
        //view.addSubview(tableView)
        view.addSubview(myTableView)
        view.addSubview(photoLabel)
        myTableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: idTableView)

    }
    
    private func setDelegates() {
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    private func setupConstraints() {
        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
//        ])
//    }
        
        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            photoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 10),
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myTableView.heightAnchor.constraint(equalToConstant: 500)
            
        ])
    }
}

    
extension PhotosVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: idTableView, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        
        let photo: Photo  = photos[indexPath.row]
        
        let photoUrl = URL(string: photo.sizes?.first?.url ?? "")
        
        cell.photoView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "default"))

        cell.setCellConfig(number: (indexPath.row + 1))
        return cell
    }
}

extension PhotosVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

//MARK: - UITableViewDataSource
//extension PhotosVC: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return photos.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        //ccылка на адрес
//        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        //cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//
//        let photo: Photo  = photos[indexPath.row]
//
//        //cell.textLabel?.text = photo.sizes?.first?.url
//
//        let photoUrl = URL(string: photo.sizes?.first?.url ?? "")
//
//        cell.imageView?.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "default"))
//
//
//
//        //cell.textLabel?.text = "\(friend.firstName ?? "")" + " " + "\(friend.lastName ?? "")"
//        //cell.detailTextLabel?.text = "\(friend.city?.title ?? "")"
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
//}

//MARK: - UITableViewDataSource
//extension PhotosVC: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//    }
//}
