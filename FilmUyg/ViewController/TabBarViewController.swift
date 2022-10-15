//
//  TabBarViewController.swift
//  FilmUyg
//
//  Created by Mert Duran on 15.06.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    var tabItem1 = UITabBarItem()
    var tabItem2 = UITabBarItem()
    var tabItem3 = UITabBarItem()
    var tabItem4 = UITabBarItem()
    
    let topIMG = UIImage(named: "MicrosoftTeams-image")
    let searchIMG = UIImage(named: "search")
    let categoryIMG = UIImage(named: "category")
    let favouriteIMG = UIImage(named: "favorite")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabItem1 = self.tabBar.items![0] //tapbarın sıfırıncı itemi bunla iliskilidir
        tabItem2 = self.tabBar.items![1]
        tabItem3 = self.tabBar.items![2]
        tabItem4 = self.tabBar.items![3]
        
        tabItem1.title = "Popüler"
        tabItem2.title = "Ara"
        tabItem3.title = "Kategoriler"
        tabItem4.title = "Favoriler"
        
        tabItem1.image = topIMG
        tabItem2.image = searchIMG
        tabItem3.image = categoryIMG
        tabItem4.image = favouriteIMG
        
    }
    

   

}
