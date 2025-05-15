//
//  TabBar.swift
//  BookStore_project
//
//  Created by Sophie on 5/11/25.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        
    }
    
    func setUp() {
        
        let addBook = AddViewController()
        let bookSearch = BookViewController()
        
        let searchNav = UINavigationController(rootViewController: bookSearch)
        let listNav = UINavigationController(rootViewController: addBook)
        
        searchNav.tabBarItem = UITabBarItem (
            title: "검색 탭",
            image: /*nil*/UIImage(named: "Tab")?.withRenderingMode(.alwaysOriginal),
            tag: 0
        )
        
        listNav.tabBarItem = UITabBarItem(
            title: "담은 책 리스트 탭",
            image: /*nil*/UIImage(named: "Tab2")?.withRenderingMode(.alwaysOriginal),
            tag: 0
        )
        
        self.viewControllers = [searchNav, listNav]
        
        var appearance: UITabBarAppearance {
            let effect = UITabBarAppearance()
            effect.backgroundColor = UIColor.white
            effect.configureWithOpaqueBackground()
            effect.stackedLayoutAppearance.normal.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.black
            ]
            return effect
        }
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        } // 있어야 백그라운드 컬러 적용됨

        
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.layer.masksToBounds = true

    }
    
    
}
