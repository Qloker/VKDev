//
//  MainTapBarController.swift
//  vk-ilia
//
//  Created by Ilia Zakharov on 17.05.2022.
//

import Foundation
import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        setupTabBar()
//        setupViews()
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

//
//
//
//
//    private func setupTabBar() {
//        tabBar.backgroundColor = .gray
//        tabBar.tintColor = .black
//        tabBar.unselectedItemTintColor = .white
//
//    }
//
//    private func setupViews() {
//
//        let friendsVC = FriendsVC()
//        let photosVC = PhotosVC()
//
//        setViewControllers([friendsVC, photosVC], animated: true)
//
//        guard let items = tabBar.items else { return }
//        items[0].title = "Friends"
//        items[0].image = UIImage(named: "Stat")
//        items[1].title = "Photos"
//        items[1].image = UIImage(named: "Vector")
//
//        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont(name: "Roboto-Medium", size: 12) as Any], for: .normal)
//    }
//
}
