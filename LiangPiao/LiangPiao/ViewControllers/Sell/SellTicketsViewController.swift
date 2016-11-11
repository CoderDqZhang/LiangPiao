//
//  BuyTicketsViewController.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SellTicketsViewController: BaseViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var serviceLabel: UILabel!
    var sigleTap:UITapGestureRecognizer!
    
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
        serviceLabel.attributedText = attribute
        serviceLabel.userInteractionEnabled = true
        logoImage.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(148 * (SCREENHEIGHT - 340)/327)
        }
        sigleTap = UITapGestureRecognizer(target: self, action: #selector(SellTicketsViewController.sigleTapPress(_:)))
        sigleTap.numberOfTapsRequired = 1
        sigleTap.numberOfTouchesRequired = 1
        serviceLabel.addGestureRecognizer(sigleTap)
    }

    func sigleTapPress(sender:UITapGestureRecognizer){
        AppCallViewShow(self.view, phone: "400-837-8011")
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
