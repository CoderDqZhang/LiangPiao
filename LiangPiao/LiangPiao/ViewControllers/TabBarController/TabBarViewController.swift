//
//  TalbViewController.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundImage = UIImage.init()
        self.tabBar.backgroundColor = UIColor.whiteColor()
        self.tabBar.shadowImage = UIImage.init()
        self.delegate = self
        self.tabBar.addSubview(GloabLineView(frame: CGRectMake(0,0,SCREENWIDTH,0.5)))
        for viewController in (self.viewControllers)! {
            print(viewController)
            for controllerVC in (viewController as! UINavigationController).viewControllers {
                if controllerVC is OrderListViewController {
                    controllerVC.viewDidLoad()
                }
            }
        }
//        self.tabBar.shadowImage = UIImage.init(color: UIColor.init(hexString: App_Theme_E9EBF2_Color), size: CGSizeMake(SCREENWIDTH, 0.2))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TabBarViewController : UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
    }
}
