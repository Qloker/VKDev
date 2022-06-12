
import Foundation
import UIKit
import SDWebImage

class AllPhotosVC: UIViewController {
    
    let photosAPIALL = PhotosAPI()
    
    var userIdALL: Int = 0
    var photosALL: [Photo] = []

    private let myCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0              //отступы
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let idCollection = "idCollection"
    
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
        
        photosAPIALL.getPhotos(userId: userIdALL) { photos in
            self.photosALL = photos
            self.myCollectionView.reloadData()
        }
        print(photosALL.count)
    }
    
    //MARK: - Private methods
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(photoLabel)
        view.addSubview(myCollectionView)
        myCollectionView.register(AllPhotosCell.self, forCellWithReuseIdentifier: idCollection)

    }
    
    private func setDelegates() {

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            photoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 10),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myCollectionView.heightAnchor.constraint(equalToConstant: 700)
            
        ])
    }
}

    
extension AllPhotosVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosALL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: idCollection, for: indexPath) as? AllPhotosCell else { return UICollectionViewCell() }
        
        let photo: Photo = photosALL[indexPath.row]
        
        let photoURL = URL(string: photo.sizes?.first?.url ?? "")
        
        cell.photoForCell.sd_setImage(with: photoURL, placeholderImage: UIImage(named: "default"))
        
        return cell
    }
    
    
}

// установка размера ячейки

extension AllPhotosVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: myCollectionView.frame.width / 3, height: myCollectionView.frame.height / 4.5)
    }
}

extension AllPhotosVC: UICollectionViewDelegate {
    
    
}
