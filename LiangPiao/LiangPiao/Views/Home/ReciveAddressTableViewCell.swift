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
        deliveryAddress.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(deliveryAddress)
        
        linLabel = GloabLineView(frame: CGRectMake(15, 0, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(linLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpData(model:OrderList) {
        if model.deliveryType == 1 {
            deliveryType.text = "配送方式：普通快递"
            deliveryName.text = "收货人：\(model.address.name) \(model.address.mobileNum)"
            let str = "\(model.address.location)\(model.address.address)".stringByReplacingOccurrencesOfString(" ", withString: "")
            deliveryAddress.text = "配送地址：\(str)"
        }else if model.deliveryType == 2 {
            deliveryType.text = "配送方式：现场取票"
            deliveryName.text = "姓名：\(model.name)"
            deliveryAddress.text = "电话：\(model.phone)"
        }else {
            deliveryType.text = "配送方式：上门自取"
            deliveryName.text = "姓名：\(model.name)"
            deliveryAddress.text = "电话：\(model.phone)"
        }
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            
            location.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.size.equalTo(CGSizeMake(21, 21))
            })
            
            deliveryType.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.location.snp_right).offset(17)
                make.top.equalTo(self.contentView.snp_top).offset(20)
            })
            
            deliveryName.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.location.snp_right).offset(17)
                make.top.equalTo(self.deliveryType.snp_bottom).offset(6)
            })
            
            deliveryAddress.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.location.snp_right).offset(17)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.top.equalTo(self.deliveryName.snp_bottom).offset(6)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
            })
            
            self.didMakeContraints = true
            
        }
        super.updateConstraints()
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
