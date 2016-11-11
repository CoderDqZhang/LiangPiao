//
//  AppThemeTool.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class AppleThemeTool {
    class func setUpToolBarColor() {
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: TablaBarItemTitleNomalColor)], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: TablaBarItemTitleSelectColor)], forState: .Selected)
        UITabBar.appearance().tintColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:NavigationBar_Title_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: NavigationBar_Title_Color)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName:NavigationBar_Title_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: NavigationBar_Title_Color)], forState: .Normal)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        UINavigationBar.appearance().setBackgroundImage(UIImage.init(color: UIColor.init(hexString: TablaBarItemTitleSelectColor), size: CGSizeMake(SCREENWIDTH, 64)), forBarMetrics: .Default)
        UINavigationBar.appearance().shadowImage = UIImage.init()
        UINavigationBar.appearance().translucent = false
        
    }
    
    class func setUpKeyBoardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false

    }
}
