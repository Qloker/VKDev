
import UIKit

class GroupsVC: UIViewController {
    
    private let groupsAPI = GroupsAPI()
    
    private var groups: [Group] = []
    
    private let groupsLabel: UILabel = {
        let label = UILabel()
        label.text = "GROUPS"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let myCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0              //отступы
       
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cellId2 = "cellId2"
    
    
    
    //MARK: - Public
    var userId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(groupsLabel)
        view.addSubview(myCollectionView)
        myCollectionView.register(GroupsCollectionViewCell.self, forCellWithReuseIdentifier: cellId2)
        
        groupsAPI.getGroups(userId: userId) { groups in
            
            self.groups = groups
            
            self.myCollectionView.reloadData()
            
            print(groups)
        }
    }
    
    private func setDelegates() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
    }
}


extension GroupsVC {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            groupsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            groupsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: groupsLabel.bottomAnchor, constant: 10),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myCollectionView.heightAnchor.constraint(equalToConstant: 610)
        
        ])
    }
}


extension GroupsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as? GroupsCollectionViewCell else { return UICollectionViewCell() }

        let group: Group = groups[indexPath.row]
        
        cell.groupConfig(group)
        
        
        return cell
    }
    
    
}

extension GroupsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: myCollectionView.frame.width, height: myCollectionView.frame.height / 4.5)
    }
}

extension GroupsVC: UICollectionViewDelegate {
    
    
}
