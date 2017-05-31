//
//  OrderAddressTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 14/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum AddAddressType {
    case withNone
    case withAddress
}

class OrderConfirmAddressTableViewCell: UITableViewCell {
    
    var orderAddAddress:UILabel!

    
    var orderName:UILabel!
    var orderAddress:UILabel!
    
    let detailImage = UIImageView()
    
    var type:AddAddressType = AddAddressType.withNone
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
    
        
        orderAddAddress = UILabel()
        orderAddAddress.text = "新增收货地址"
        orderAddAddress.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        orderAddAddress.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(orderAddAddress)
        
        
        detailImage.image = UIImage.init(named: "Btn_More")
        self.contentView.addSubview(detailImage)
        
        lineLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        
        orderName = UILabel()
        orderName.text = ""
        orderName.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        orderName.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(orderName)
        
        orderAddress = UILabel()
        orderAddress.text = ""
        orderAddress.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        orderAddress.font = App_Theme_PinFan_R_13_Font
        orderAddress.numberOfLines = 0
        self.contentView.addSubview(orderAddress)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(_ model:AddressModel, type:AddAddressType) {
        
        if type == .withNone {
            orderName.isHidden = true
            orderAddress.isHidden = true
            orderAddAddress.isHidden = false
        }else{
            orderName.isHidden = false
            orderAddress.isHidden = false
            orderAddAddress.isHidden = true
            orderName.text = "\((model.name)!) \((model.mobileNum)!)"
            let str = "\((model.location)!)\((model.address)!)".replacingOccurrences(of: " ", with: "")
            orderAddress.text = str
        }
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
        
            orderAddAddress.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15.5)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
            })
            
            detailImage.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(6)
            })
            
            orderName.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(25)
                make.left.equalTo(self.contentView.snp.left).offset(15)
            })
            
            orderAddress.snp.makeConstraints({ (make) in
                make.top.equalTo(self.orderName.snp.bottom).offset(1)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
            })
            
            lineLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-0.5)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected( _ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
