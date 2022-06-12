
import Foundation
import UIKit
import SDWebImage

class PhotosVC: UIViewController {
    
    let photosAPI = PhotosAPI()
    
    var userId: Int = 0
    var photos: [Photo] = []
    

    private let myTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = #colorLiteral(red: 1, green: 0.9961672425, blue: 0.832010746, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delaysContentTouches = false                            ы
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let idTableView = "idTableView"
    
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
            self.photos = photos
            self.myTableView.reloadData()
        }
        print(photos.count)
    }
    
    //MARK: - Private methods
    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(myTableView)
        view.addSubview(photoLabel)
        myTableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: idTableView)

    }
    
    private func setDelegates() {
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    private func setupConstraints() {
        
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
