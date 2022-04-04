//
//  TabBarViewController.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeController = HomeViewController()
        let searchController = SearchViewController()
        let libraryController = LibraryViewController()
        
        //set tabbar title
//        homeController.title = "Browse"
        searchController.title = "Search"
        libraryController.title = "Library"
        
        homeController.navigationItem.largeTitleDisplayMode = .always
        searchController.navigationItem.largeTitleDisplayMode = .always
        libraryController.navigationItem.largeTitleDisplayMode = .always
        
        let homeNavigation = UINavigationController(rootViewController: homeController)
        let searchNavigation = UINavigationController(rootViewController: searchController)
        let libraryNavigation = UINavigationController(rootViewController: libraryController)
        
        homeNavigation.navigationBar.tintColor = .label
        searchNavigation.navigationBar.tintColor = .label
        libraryNavigation.navigationBar.tintColor = .label
        
        //set tabbar icon
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        searchNavigation.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        libraryNavigation.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        homeNavigation.navigationBar.prefersLargeTitles = true
        searchNavigation.navigationBar.prefersLargeTitles = true
        libraryNavigation.navigationBar.prefersLargeTitles = true
        
        setViewControllers([homeNavigation, searchNavigation, libraryNavigation], animated: false)
    }

}
