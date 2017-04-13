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
        self.backgroundColor = UIColor.white
        self.setUpView()
    }
    
    func setUpView() {
        seveiceImage = UIImageView()
        seveiceImage.image = UIImage.init(named: "Icon_Info")
        self.contentView.addSubview(seveiceImage)
        
        muchLabel = UILabel()
        muchLabel.text = "交易手续费：00.00 元"
        UILabel.changeLineSpace(for: muchLabel, withSpace: 3.0)
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
    

    func setData(_ much:String, servicemuch:String, sevicep:String, type:NSInteger){
        muchLabel.text = much
        seveiceMuch.text = servicemuch
        serviceP.text = sevicep
        UILabel.changeLineSpace(for: serviceP, withSpace: 2.0)
        switch type {
        case 0:
            muchLabel.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.contentView.snp.left).offset(15)
            })
            seveiceImage.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.seveiceMuch.snp.right).offset(8)
                make.size.equalTo(CGSize.init(width: 15, height: 15))
            })
            seveiceMuch.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.muchLabel.snp.right).offset(20)
            })
            let strArray = much.components(separatedBy: " ")
            let strribute = NSMutableAttributedString.init(string: much)
            strribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_4BD4C5_Color)], range: NSRange.init(location: strArray[0].length + 1, length: strArray[1].length))
            muchLabel.attributedText = strribute
        default:
            seveiceImage.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.seveiceMuch.snp.right).offset(8)
                make.size.equalTo(CGSize.init(width: 15, height: 15))
            })
            
            seveiceMuch.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.muchLabel.snp.right).offset(20)
            })
        }
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            muchLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.contentView.snp.left).offset(15)
            })
            
            seveiceImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.muchLabel.snp.right).offset(8)
                make.size.equalTo(CGSize.init(width: 15, height: 15))
            })
            
            seveiceMuch.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.seveiceImage.snp.right).offset(20)
            })
            
            serviceP.snp.makeConstraints({ (make) in
                make.top.equalTo(self.muchLabel.snp.bottom).offset(8)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-26)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
