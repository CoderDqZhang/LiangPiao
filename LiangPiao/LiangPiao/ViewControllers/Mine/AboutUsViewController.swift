//
//  AboutUsViewController.swift
//  LiangPiao
//
//  Created by Zhang on 09/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView(){
        let leftImage = UIImage.init(named: "Icon_Back_Normal")
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRectMake(15, 20, 40, 40)
        backButton.addTarget(self, action: #selector(UIViewController.backBtnPress(_:)), forControlEvents: .TouchUpInside)
        backButton.setImage(leftImage, forState: .Normal)
        self.view.addSubview(backButton)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
