//
//  TicketLocationTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketLocationTableViewCell: UITableViewCell {

    var addressLabel:UILabel!
    var detailAddress:UILabel!
    var locationButton:UIButton!
    var messageLabel:UILabel!
    var linLabel1:UILabel!
    var linLabel2:UILabel!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        addressLabel = UILabel()
        addressLabel.text = "大隐剧院"
        addressLabel.font = App_Theme_PinFan_R_13_Font
        addressLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        addressLabel.numberOfLines = 0
        self.contentView.addSubview(addressLabel)
        
        detailAddress = UILabel()
        detailAddress.text = "光华路9号世贸天阶 C 座时尚大厦5楼"
        detailAddress.font = App_Theme_PinFan_R_12_Font
        detailAddress.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        detailAddress.numberOfLines = 0
        self.contentView.addSubview(detailAddress)
        
        locationButton = UIButton(type: .Custom)
        locationButton.buttonSetImage(UIImage.init(named: "Order_Address_Location")!, sImage: UIImage.init(named: "Order_Address_Location_Pressed")!)
        self.contentView.addSubview(locationButton)
        
        linLabel1 = UILabel()
        linLabel1.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.contentView.addSubview(linLabel1)
        
        linLabel2 = UILabel()
        linLabel2.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.contentView.addSubview(linLabel2)
        
        messageLabel = UILabel()
        messageLabel.font = App_Theme_PinFan_R_12_Font
        messageLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        messageLabel.numberOfLines = 0
        self.contentView.addSubview(messageLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList){
        addressLabel.text = model.show.venue.name
        detailAddress.text = model.show.venue.address
        UILabel.changeLineSpaceForLabel(detailAddress, withSpace: 2.0)

        if model.message != "" {
            linLabel2.hidden = false
            messageLabel.hidden = false
            messageLabel.text = "备注：\(model.message)"
            UILabel.changeLineSpaceForLabel(messageLabel, withSpace: 2.0)
            linLabel1.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.top.equalTo(self.detailAddress.snp_bottom).offset(20)
                make.height.equalTo(0.5)
            })
            
            messageLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.top.equalTo(self.linLabel1.snp_bottom).offset(20)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.linLabel2.snp_top).offset(-20)
            })
            
            linLabel2.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
                make.height.equalTo(0.5)
            })
        }else{
            linLabel2.hidden = true
            messageLabel.hidden = true
            linLabel1.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
                make.height.equalTo(0.5)
            })
            detailAddress.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.addressLabel.snp_bottom).offset(3)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.locationButton.snp_left).offset(-10)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
            })
        }
        self.updateConstraintsIfNeeded()
//        messageLabel.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            addressLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.top.equalTo(self.contentView.snp_top).offset(20)
            })
            
            detailAddress.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.addressLabel.snp_bottom).offset(3)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.locationButton.snp_left).offset(-10)
            })
            
            locationButton.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.height.equalTo(37)
                make.width.equalTo(37)
            })
            
            linLabel1.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.top.equalTo(self.contentView.snp_top).offset(84)
                make.height.equalTo(0.5)
            })
            
//            messageLabel.snp_makeConstraints(closure: { (make) in
//                make.right.equalTo(self.contentView.snp_right).offset(0)
//                make.top.equalTo(self.linLabel1.snp_bottom).offset(23)
//                make.left.equalTo(self.contentView.snp_left).offset(15)
//                make.right.equalTo(self.contentView.snp_right).offset(-15)
//            })

            self.didMakeConstraints = true
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
