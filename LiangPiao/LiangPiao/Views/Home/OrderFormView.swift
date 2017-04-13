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
    var muchmLabel:UILabel!
    var payButton:UIButton!
    var didMakeConstraints:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.setUpView()
    }
    
    func setUpView() {
        muchInfoLabel = UILabel()
        muchInfoLabel.text = "实付金额："
        muchInfoLabel.font = App_Theme_PinFan_R_14_Font
        muchInfoLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.addSubview(muchInfoLabel)
        
        muchLabel = UILabel()
        muchLabel.font = App_Theme_PinFan_R_18_Font
        muchLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchLabel.text = "688.00"
        
        muchmLabel = UILabel()
        muchmLabel.font = App_Theme_PinFan_R_10_Font
        muchmLabel.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        muchmLabel.text = "元"
        self.addSubview(muchmLabel)
        
        self.addSubview(muchLabel)
        
        payButton = UIButton(type: .custom)
        payButton.setTitle("提交订单", for: UIControlState())
        payButton.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        payButton.titleLabel?.font = App_Theme_PinFan_R_15_Font
        payButton.frame = CGRect(x: SCREENWIDTH - 120, y: 0, width: 120, height: 49)
        self.addSubview(payButton)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setMuchLabelText(_ text:String){
        muchLabel.text = text
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchInfoLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(15)
                make.top.equalTo(self.snp.top).offset(18)
            })
            muchLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.muchInfoLabel.snp.right).offset(4)
                make.top.equalTo(self.snp.top).offset(15)
            })
            
            muchmLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.muchLabel.snp.right).offset(4)
                make.top.equalTo(self.snp.top).offset(21)
                //                make.centerY.equalTo(self.snp.centerY).offset(0)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
