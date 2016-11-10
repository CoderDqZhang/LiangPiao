//
//  BuyTicketsViewController.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SellTicketsViewController: BaseViewController {

    @IBOutlet weak var serviceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        let str = "暂时可联系客服 400-837-8011 售票"
        let attribute = NSMutableAttributedString(string: str)
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: Sell_View_Title_bColor)], range: NSRange(location: 0, length: 8))
        attribute.addAttributes([NSFontAttributeName:Sell_View_Title_Font!], range: NSRange.init(location: 0, length: 8))
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_BackGround_Color)], range: NSRange(location: 8, length: 12))
        attribute.addAttributes([NSFontAttributeName:Sell_View_Title_Font!], range: NSRange.init(location: 8, length: 12))
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: Sell_View_Title_bColor)], range: NSRange(location: 14, length: 2))
        attribute.addAttributes([NSFontAttributeName:Sell_View_Title_Font!], range: NSRange.init(location: 14, length: 2))
        serviceLabel.attributedText = attribute
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
