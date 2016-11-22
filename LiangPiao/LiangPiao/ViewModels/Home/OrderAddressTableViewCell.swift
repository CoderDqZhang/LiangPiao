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
        orderAddAddress.textColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        orderAddAddress.font = Mine_Address_Name_Font
        self.contentView.addSubview(orderAddAddress)
        
        
        detailImage.image = UIImage.init(named: "Btn_More")
        self.contentView.addSubview(detailImage)
        
        lineLabel = GloabLineView(frame: CGRectMake(15, 0, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        
        orderName = UILabel()
        orderName.text = "冉灿    18602035508"
        orderName.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
        orderName.font = Mine_Address_Name_Font
        self.contentView.addSubview(orderName)
        
        orderAddress = UILabel()
        orderAddress.text = "朝阳区香河园小区西坝河中里35号楼二层207"
        orderAddress.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
        orderAddress.font = Mine_Address_Name_Font
        self.contentView.addSubview(orderAddress)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(name:String, address:String, type:AddAddressType) {
        
        if type == .withNone {
            orderName.hidden = true
            orderAddress.hidden = true
            orderAddAddress.hidden = false
        }else{
            orderName.hidden = false
            orderAddress.hidden = false
            orderAddAddress.hidden = true
            orderName.text = name
            orderAddress.text = address
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
        
            orderAddAddress.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15.5)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            detailImage.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            orderName.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.orderAddress.snp_top).offset(-1)
            })
            
            orderAddress.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.orderName.snp_bottom).offset(1)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-14)
            })
            
            lineLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected( selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
