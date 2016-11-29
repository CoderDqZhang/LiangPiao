//
//  OrderFormView.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class ConfirmView: UIView {
    var muchInfoLabel:UILabel!
    var muchLabel:UILabel!
    var payButton:UIButton!
    var didMakeConstraints:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.setUpView()
    }
    
    func setUpView() {
        muchInfoLabel = UILabel()
        muchInfoLabel.text = "实付金额："
        muchInfoLabel.font = Home_PayView_Label_Font
        muchInfoLabel.textColor = UIColor.init(hexString: Home_Ticker_Tools_Table_sColor)
        self.addSubview(muchInfoLabel)
        
        muchLabel = UILabel()
        muchLabel.text = "688.00 元"
        
        self.addSubview(muchLabel)
        
        payButton = UIButton(type: .Custom)
        payButton.setTitle("提交订单", forState: .Normal)
        payButton.backgroundColor = UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor)
        payButton.titleLabel?.font = Home_PayView_Button_Title_Font
        payButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            
        }
        payButton.frame = CGRectMake(SCREENWIDTH - 120, 0, 120, 49)
        self.addSubview(payButton)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setMuchLabelText(text:String){
        muchLabel.text = text
        let attributeString = NSMutableAttributedString(string: muchLabel.text!)
        attributeString.addAttribute(NSFontAttributeName,
                                     value: Home_PayView_Much_Font!,
                                     range: NSMakeRange(0,muchLabel.text!.length - 1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor),
                                     range: NSMakeRange(0, muchLabel.text!.length - 1))
        attributeString.addAttribute(NSFontAttributeName,
                                     value: Home_PayView_MuchLabel_Font!,
                                     range: NSMakeRange(muchLabel.text!.length - 1,1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: Home_Ticker_Descrip_Color),
                                     range: NSMakeRange(muchLabel.text!.length - 1,1))
        muchLabel.attributedText = attributeString
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchInfoLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.snp_left).offset(15)
                make.top.equalTo(self.snp_top).offset(16)
//                make.centerY.equalTo(self.snp_centerY).offset(0)
            })
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.muchInfoLabel.snp_right).offset(4)
                make.top.equalTo(self.snp_top).offset(15)
//                make.centerY.equalTo(self.snp_centerY).offset(0)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
