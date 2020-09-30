//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Apple on 9/22/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(),craeteFavoritesNC()]
    }
    
    
    func createSearchNC() -> UINavigationController {
        //create Search viewController
        let searchNC = SearchVC()
        searchNC.title = "Search"
        searchNC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchNC)
    }
    
    
    func craeteFavoritesNC() -> UINavigationController {
        //create FavoritesList viewController
        let favoriteListNC = FavoritesListVC()
        favoriteListNC.title = "Favorite"
        favoriteListNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteListNC)
    }
}
