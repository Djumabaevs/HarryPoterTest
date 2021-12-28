//
//  TabBarViewController.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import UIKit

class TabBarViewController: UITabBarController{
    
    lazy var episodesVC: EpisodeViewController = {
        let vc = EpisodeViewController()
        vc.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage.init(systemName: "list.number"), tag: 0)
        vc.tabBarItem.selectedImage?.withTintColor(UIColor.blue)
        vc.title = "Episodes"
        return vc
    }()
    
    lazy var charactersVC: CharacterViewController = {
        let vc = CharacterViewController()
        vc.tabBarItem = UITabBarItem(title: "Characters", image: UIImage.init(systemName: "person.2"), tag: 1)
        vc.tabBarItem.selectedImage?.withTintColor(UIColor.blue)
        vc.title = "Characters"
        return vc
    }()
    
    lazy var locationsVC: LocationViewController = {
        let vc = LocationViewController()
        vc.tabBarItem = UITabBarItem(title: "Locations", image: UIImage.init(systemName: "location"), tag: 2)
        vc.tabBarItem.selectedImage?.withTintColor(UIColor.blue)
        vc.navigationItem.title = "Locations"
        return vc
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.viewControllers = [charactersVC, episodesVC,locationsVC]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item == tabBar.items?[0] {
            title = "Characters"
            navigationController?.title = "Characters"
        }
        
        else if item == tabBar.items?[1] {
            title = "Episodes"
            navigationController?.title = "Episodes"
        }
        
        else if item == tabBar.items?[2] {
            navigationController?.title = "Locations"
            title = "Locations"
        }
    }

}
