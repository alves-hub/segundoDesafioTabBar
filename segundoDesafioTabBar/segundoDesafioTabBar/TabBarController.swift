//
//  TabBarController.swift
//  segundoDesafioTabBar
//
//  Created by Jefferson Alves on 06/05/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configItems()
        configTabBar()
       
    }
    
    func configItems(){
        guard let items = tabBar.items else { return }
        
        items[0].title = "Upload/Fotos"
        items[0].image = UIImage(systemName:"camera")
        items[1].title = "Phone"
        items[1].image = UIImage(systemName:"phone")
        items[2].title = "Lixeira"
        items[2].image = UIImage(systemName:"trash")
    }
    
    func configTabBar(){
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor  = UIColor.black.cgColor
        tabBar.backgroundColor = .white
    }
    


}
