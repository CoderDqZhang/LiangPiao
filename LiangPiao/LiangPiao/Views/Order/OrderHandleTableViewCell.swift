//
//  OrderHandleTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderHandleTableViewCell: UITableViewCell {

    var cancelOrderBtn:UIButton!
    var payOrderBtn:UIButton!
    var didMakeContraints:Bool = false
    
    var linLabel:GloabLineView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        cancelOrderBtn = self.createButton("取消订单", backGround: UIColor.white, titleColor: UIColor.init(hexString: App_Theme_4BD4C5_Color))
        cancelOrderBtn.buttonSetTitleColor(App_Theme_4BD4C5_Color, sTitleColor: App_Theme_40C6B7_Color)
        self.contentView.addSubview(cancelOrderBtn)
        
        payOrderBtn = self.createButton("立即支付", backGround: UIColor.init(hexString: App_Theme_4BD4C5_Color), titleColor: UIColor.white)
        payOrderBtn.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: 80, height: 30))
        self.contentView.addSubview(payOrderBtn)
        
        linLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(linLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func createButton(_ title:String, backGround:UIColor, titleColor:UIColor) -> UIButton {
        let  button = UIButton(type: .custom)
        button.setTitle(title, for: UIControlState())
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = App_Theme_PinFan_R_13_Font
        button.layer.backgroundColor = backGround.cgColor
        button.layer.borderColor = titleColor.cgColor
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.setTitleColor(titleColor, for: UIControlState())
        if backGround != UIColor.init(hexString: App_Theme_4BD4C5_Color) {
            button.layer.cornerRadius = 2.0
            button.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
            button.layer.borderWidth = 1.0
        }else{
            button.layer.cornerRadius = 2.0
            button.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).cgColor
            button.layer.borderWidth = 1.0
        }
        return button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            
            cancelOrderBtn.snp.makeConstraints({ (make) in
                make.right.equalTo(self.payOrderBtn.snp.left).offset(-12)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo( CGSize.init(width: 80, height: 30))
            })
            
            payOrderBtn.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 80, height: 30))
            })
            
            self.didMakeContraints = true
            
        }
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
