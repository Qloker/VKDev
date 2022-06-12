
import Foundation
import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)


        self.tabBar.barTintColor = .white

        let friendsVC = FriendsVC()
        let friendsTabBarIcon = UITabBarItem()
        friendsTabBarIcon.image = UIImage(named: "Stat")
        friendsVC.tabBarItem = friendsTabBarIcon

        let groupsVC = GroupsVC()
        let groupsTabBarIcon = UITabBarItem()
        groupsTabBarIcon.image = UIImage(named: "Vector")
        groupsVC.tabBarItem = groupsTabBarIcon

        let photoVC = PhotosVC()
        let photosTabBarIcon = UITabBarItem()
        photosTabBarIcon.image = UIImage(named: "Stat")
        photoVC.tabBarItem = photosTabBarIcon
        
        let allPhotosVC = AllPhotosVC()
        let allPhotosTabBarIcon = UITabBarItem()
        allPhotosTabBarIcon.image = UIImage(named: "Vector")
        allPhotosVC.tabBarItem = allPhotosTabBarIcon
        

        let controller = [friendsVC, groupsVC, photoVC, allPhotosVC]
        self.viewControllers = controller


    }
}
