//
//  AppThemeTool.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation
import UIKit

class AppleThemeTool {
    class func setUpToolBarColor() {
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: TablaBarItemTitleNomalColor)], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: TablaBarItemTitleSelectColor)], forState: .Selected)
        UITabBar.appearance().tintColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:NavigationBar_Title_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: NavigationBar_Title_Color)]
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        
    }
}
