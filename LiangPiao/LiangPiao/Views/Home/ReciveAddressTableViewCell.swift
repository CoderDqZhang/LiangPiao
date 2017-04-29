//
//  ReciveAddressTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class ReciveAddressTableViewCell: UITableViewCell {

    var location:UIImageView!
    var deliveryType:UILabel!
    var deliveryName:UILabel!
    var deliveryAddress:UILabel!
    var didMakeContraints:Bool = false

    var linLabel:GloabLineView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        location = UIImageView()
        location.image = UIImage.init(named: "Icon_Location")
        self.contentView.addSubview(location)
        
        deliveryType = UILabel()
        deliveryType.font = App_Theme_PinFan_R_13_Font
        deliveryType.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(deliveryType)
        
        deliveryName = UILabel()
        deliveryName.font = App_Theme_PinFan_R_13_Font
        deliveryName.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(deliveryName)
        
        deliveryAddress = UILabel()
        deliveryAddress.font = App_Theme_PinFan_R_13_Font
        deliveryAddress.numberOfLines = 0
        deliveryAddress.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(deliveryAddress)
        
        linLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(linLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpData(_ model:OrderList) {
        if model.deliveryType == 1 || model.deliveryType == 4 {
            self.deliveryType.text = "配送方式：快递到付"
            self.deliveryName.text = "收货人：\((model.address.name)!) \((model.address.mobileNum)!)"
            let str = "\((model.address.location)!)\((model.address.address)!)".replacingOccurrences(of: " ", with: "")
            self.deliveryAddress.text = "配送地址：\(str)"
        }else if model.deliveryType == 2 {
            self.deliveryType.text = "配送方式：现场取票"
            self.deliveryName.text = "姓名：\((model.name)!)"
            self.deliveryAddress.text = "电话：\((model.phone)!)"
        }else {
            self.deliveryType.text = "配送方式：上门自取"
            self.deliveryName.text = "姓名：\((model.name)!)"
            self.deliveryAddress.text = "电话：\((model.phone)!)"
        }
        self.deliveryAddress.numberOfLines = 0
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            
            location.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 21, height: 21))
            })
            
            deliveryType.snp.makeConstraints({ (make) in
                make.left.equalTo(self.location.snp.right).offset(17)
                make.top.equalTo(self.contentView.snp.top).offset(20)
            })
            
            deliveryName.snp.makeConstraints({ (make) in
                make.left.equalTo(self.location.snp.right).offset(17)
                make.top.equalTo(self.deliveryType.snp.bottom).offset(6)
            })
            
            deliveryAddress.snp.makeConstraints({ (make) in
                make.left.equalTo(self.location.snp.right).offset(17)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.deliveryName.snp.bottom).offset(6)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
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
