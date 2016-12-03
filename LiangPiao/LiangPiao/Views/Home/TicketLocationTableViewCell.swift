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
    var linLabel:UILabel!
    var linLabel1:UILabel!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        addressLabel = UILabel()
        addressLabel.text = "大隐剧院"
        addressLabel.font = GlobalCell_Title_Font
        addressLabel.textColor = UIColor.init(hexString: GlobalCell_Title_Color)
        addressLabel.numberOfLines = 0
        self.contentView.addSubview(addressLabel)
        
        detailAddress = UILabel()
        detailAddress.text = "光华路9号世贸天阶 C 座时尚大厦5楼"
        detailAddress.font = Home_OrderConfirmCell_Info_Font
        detailAddress.textColor = UIColor.init(hexString: Home_OrderConfirmCell_Info_Color)
        detailAddress.numberOfLines = 0
        self.contentView.addSubview(detailAddress)
        
        locationButton = UIButton(type: .Custom)
        locationButton.setImage(UIImage.init(named: "Order_Address_Location"), forState: .Normal)
        self.contentView.addSubview(locationButton)
        
        linLabel = UILabel()
        linLabel.backgroundColor = UIColor.init(hexString: Line_BackGround_Color)
        self.contentView.addSubview(linLabel)
        
        linLabel1 = UILabel()
        linLabel1.backgroundColor = UIColor.init(hexString: Line_BackGround_Color)
        self.contentView.addSubview(linLabel1)
        
        messageLabel = UILabel()
        messageLabel.font = OrderDetail_Message_Font
        messageLabel.textColor = UIColor.init(hexString: OrderDetail_Message_Color)
        messageLabel.numberOfLines = 0
        self.contentView.addSubview(messageLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList){
        addressLabel.text = model.show.venue.name
        detailAddress.text = model.show.venue.address
//        let str = "开发者使用这门语言进行 iOS 应用开发,在开发中 我们常常需要用到各种字符串、类、接口等等,今天小编和大家分享的就是 swift2.0 中 String 的类型转换..."
        if model.message != "" {
            messageLabel.text = "备注信息：\(model.message)"
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
                make.top.equalTo(self.contentView.snp_top).offset(22)
            })
            
            detailAddress.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.addressLabel.snp_bottom).offset(3)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.locationButton.snp_left).offset(-10)
            })
            
            locationButton.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(0)
                make.top.equalTo(self.contentView.snp_top).offset(0)
                make.height.equalTo(80)
                make.width.equalTo(80)
            })
            
            linLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-80)
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.height.equalTo(40)
                make.width.equalTo(0.5)
            })
            
            linLabel1.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.top.equalTo(self.contentView.snp_top).offset(84)
                make.height.equalTo(0.5)
            })
            
            messageLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(0)
                make.top.equalTo(self.linLabel1.snp_bottom).offset(23)
                make.left.equalTo(self.contentView.snp_left).offset(15)
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
