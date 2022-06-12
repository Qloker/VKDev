//
//  FriendsViewController.swift
//  vk-ilia
//
//  Created by Artur Igberdin on 06.04.2022.
//

import UIKit

final class FriendsVC: UIViewController {

    //MARK: - Private properties
    private let friendsAPI = FriendsAPI()
    
    private var friends: [Friend] = []
    
    //Основной способ создания UI контролов - если нет кастомных классов под это дело
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        return tableView
//    }()
    
    private let myCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3              //отступы
       
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cellId = "cellId"
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = "Друзья"
//        navigationItem.leftBarButtonItem = nil// UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        setupViews()
        setupConstraints()
        setDelegates()
        
        friendsAPI.getFriends { result in
  
            
            switch result {
            case .success(let friends):
                self.friends = friends
                self.myCollectionView.reloadData()
                
            case .failure(let error):
                
                print("error", error)
                self.errorAlert(title: "Error", message: "Try again")

            }
            
           
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
       
    }
    
    //MARK: - Private methods
    private func setupViews() {
//        view.addSubview(tableView)
        
        view.backgroundColor = .white
        view.addSubview(myCollectionView)
        myCollectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setDelegates() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
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
        
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myCollectionView.heightAnchor.constraint(equalToConstant: 500)
            //collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    //MARK: - Actions
    
    private func showFriendPhotosAction(index: Int) {
        
        //Переход на новый контроллер FriendsFavoritePhotoVC
    }
}

extension FriendsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friends.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FriendCollectionViewCell else { return UICollectionViewCell() }
        
        let friend: Friend = friends[indexPath.row]

        //Ответственность на расстановку свойств ячейки отдали в ячейку
        cell.configure(friend)
        
        //Контроллер -> tableview -> cell -> кложур
        cell.onGroupTapAction = { userId in
            
            
            let groupsVC = GroupsVC()
            
            groupsVC.userId = userId
            
            self.navigationController?.pushViewController(groupsVC, animated: true)
        }
        
        cell.onPhotoTapAction = { userId in
            
            let photoVC = PhotosVC()
            photoVC.userId = userId
            self.navigationController?.pushViewController(photoVC, animated: true)
        }
       
        return cell
    }
    
}

extension FriendsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // теперь не нужно т.к. переход через кнопки
//        showFriendPhotosAction(index: indexPath.row)
//
//        print("Нажатие ячейки = ", indexPath.row)
//
//        let friend: Friend = friends[indexPath.row]
//        //print(friend.id)
//
//        //Передача данных через инициализатор
//        //let photosVC = PhotosVC(userId: friend.id)
//
//        //Переда данных через внутреннюю переменную
//        let photosVC = PhotosVC()
//        photosVC.userId = friend.id
//
//        navigationController?.pushViewController(photosVC, animated: true)
        
    }
    
}
extension FriendsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: myCollectionView.frame.width, height: myCollectionView.frame.height / 3.8)
    }
}
////MARK: - UITableViewDataSource
//extension FriendsVC: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return friends.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        //ccылка на адрес
//        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
//
//        let friend: Friend = friends[indexPath.row]
//
//        cell.textLabel?.text = "\(friend.firstName ?? "")" + " " + "\(friend.lastName ?? "")"
//        cell.detailTextLabel?.text = "\(friend.city?.title ?? "")"
//
//        return cell
//    }
//}
//
////MARK: - UITableViewDataSource
//extension FriendsVC: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        showFriendPhotosAction(index: indexPath.row)
//
//        print("Нажатие ячейки = ", indexPath.row)
//
//        let friend: Friend = friends[indexPath.row]
//        print(friend.id)
//
//        //Передача данных через инициализатор
//        //let photosVC = PhotosVC(userId: friend.id)
//
//        //Переда данных через внутреннюю переменную
//        let photosVC = PhotosVC()
//        photosVC.userId = friend.id
//
//        navigationController?.pushViewController(photosVC, animated: true)
//    }
//}
