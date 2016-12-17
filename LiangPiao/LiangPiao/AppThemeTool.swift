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
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_8A96A2_Color)], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_4BD4C5_Color)], forState: .Selected)
        UITabBar.appearance().tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:App_Theme_PinFan_L_17_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_FFFFFF_Color)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName:App_Theme_PinFan_L_15_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_FFFFFF_Color)], forState: .Normal)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        UINavigationBar.appearance().setBackgroundImage(UIImage.init(color: UIColor.init(hexString: App_Theme_4BD4C5_Color), size: CGSizeMake(SCREENWIDTH, 64)), forBarMetrics: .Default)
        UINavigationBar.appearance().shadowImage = UIImage.init()
        UINavigationBar.appearance().translucent = false
        
    }
    
    class func setUpKeyBoardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false

    }
}
