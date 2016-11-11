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
    var linLabel:UILabel!
    
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
        
        self.updateConstraintsIfNeeded()
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
                make.top.equalTo(self.addressLabel.snp_bottom).offset(1)
                make.left.equalTo(self.contentView.snp_left).offset(15)
            })
            
            locationButton.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(0)
                make.top.equalTo(self.contentView.snp_top).offset(0)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(0)
                make.width.equalTo(80)
            })
            
            linLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-80)
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
                make.width.equalTo(0.5)
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