//
//  MySellServiceTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 08/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellServiceTableViewCell: UITableViewCell {

    var seveiceImage:UIImageView!
    var muchLabel:UILabel!
    var seveiceMuch:UILabel!
    var ticketmMuch:UILabel!
    var serviceP:UILabel!
    
    var tickType:OrderType = .orderWaitPay
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        self.setUpView()
    }
    
    func setUpView() {
        seveiceImage = UIImageView()
        seveiceImage.image = UIImage.init(named: "Icon_Info")
        self.contentView.addSubview(seveiceImage)
        
        muchLabel = UILabel()
        muchLabel.text = "交易服务费：00.00 元"
        UILabel.changeLineSpaceForLabel(muchLabel, withSpace: 3.0)
        muchLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        muchLabel.font = App_Theme_PinFan_R_13_Font
        muchLabel.numberOfLines = 0
        self.contentView.addSubview(muchLabel)
        
        seveiceMuch = UILabel()
        seveiceMuch.text = "结算总价：00.00 元"
        seveiceMuch.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        seveiceMuch.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(seveiceMuch)
        
        serviceP = UILabel()
        serviceP.text = "第三方支付交易手续费1%\n订单票款结算金额将于演出结束后24小时内转入账户钱包中"
        serviceP.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        serviceP.numberOfLines = 0
        serviceP.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(serviceP)
        
        self.updateConstraintsIfNeeded()
        
    }
    

    func setData(much:String, servicemuch:String, sevicep:String, type:NSInteger){
        muchLabel.text = much
        seveiceMuch.text = servicemuch
        serviceP.text = sevicep
        switch type {
        case 0:
            seveiceImage.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(26)
                make.left.equalTo(self.muchLabel.snp_right).offset(8)
                make.size.equalTo(CGSizeMake(15, 15))
            })
            seveiceMuch.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(26)
                make.left.equalTo(self.seveiceImage.snp_right).offset(20)
            })
            let strArray = servicemuch.componentsSeparatedByString(" ")
            let strribute = NSMutableAttributedString.init(string: servicemuch)
            strribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_4BD4C5_Color)], range: NSRange.init(location: strArray[0].length + 1, length: strArray[1].length))
            seveiceMuch.attributedText = strribute
        default:
            seveiceImage.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(26)
                make.left.equalTo(self.seveiceMuch.snp_right).offset(8)
                make.size.equalTo(CGSizeMake(15, 15))
            })
            
            seveiceMuch.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(26)
                make.left.equalTo(self.muchLabel.snp_right).offset(20)
            })
        }
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(26)
                make.left.equalTo(self.contentView.snp_left).offset(15)
            })
            
            seveiceImage.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(26)
                make.left.equalTo(self.muchLabel.snp_right).offset(8)
                make.size.equalTo(CGSizeMake(15, 15))
            })
            
            seveiceMuch.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(26)
                make.left.equalTo(self.seveiceImage.snp_right).offset(20)
            })
            
            serviceP.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.muchLabel.snp_bottom).offset(8)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-26)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
