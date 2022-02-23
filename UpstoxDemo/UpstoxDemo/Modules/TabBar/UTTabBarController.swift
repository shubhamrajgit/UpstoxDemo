//
//  UTTabBarController.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 12/02/22.
//

import UIKit

class UTTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarAppereance()
    }
    
    private func setTabBarAppereance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.tabBgColor
        self.tabBar.tintColor = UIColor.themeColor
        self.tabBar.unselectedItemTintColor = UIColor.tabUnselectedColor
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Draw Indicator above the tab bar items
        guard let numberOfTabs = tabBar.items?.count else {
            return
        }
        
        let numberOfTabsFloat = CGFloat(numberOfTabs)
        let imageSize = CGSize(width: tabBar.frame.width / numberOfTabsFloat,
                               height: tabBar.frame.height)
        
        
        let indicatorImage = UIImage.drawTabBarIndicator(color: UIColor.themeColor,
                                                         size: imageSize,
                                                         onTop: true)
        self.tabBar.selectionIndicatorImage = indicatorImage
    }

}
