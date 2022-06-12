
import UIKit

final class FriendsVC: UIViewController {

    //MARK: - Private properties
    private let friendsAPI = FriendsAPI()
    
    private var friends: [Friend] = []
    
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

        view.backgroundColor = .white
        view.addSubview(myCollectionView)
        myCollectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setDelegates() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myCollectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    //MARK: - Actions
}

extension FriendsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friends.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FriendCollectionViewCell else { return UICollectionViewCell() }
        
        let friend: Friend = friends[indexPath.row]
        cell.configure(friend)
        
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
    }
    
}
extension FriendsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: myCollectionView.frame.width, height: myCollectionView.frame.height / 3.8)
    }
}
