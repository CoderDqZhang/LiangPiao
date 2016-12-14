//
//  OrderTypeTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderWaitePayTableViewCell: UITableViewCell {

    var orderType:OrderType!
    
    var orderStatusWait:UILabel!
    var orderTime:UILabel!
    var orderImage:UIImageView!
    
    var orderStatusDone:UILabel!
    
    var orderName:UILabel!
    var orderAddress:UILabel!
    
    var lineLabel:GloabLineView!
    
    var orderCountDownView:OrderCountDownView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        orderStatusWait = UILabel()
        orderStatusWait.font = App_Theme_PinFan_M_16_Font
        orderStatusWait.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        orderStatusWait.text = "待付款"
        self.contentView.addSubview(orderStatusWait)
        
        orderTime = UILabel()
        orderTime.text = "剩余支付时间:"
        orderTime.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        orderTime.font = App_Theme_PinFan_R_11_Font
        self.contentView.addSubview(orderTime)
        
        orderImage = UIImageView()
        orderImage.image = UIImage.init(named: "order_waitPay")
        self.contentView.addSubview(orderImage)
        
        
        lineLabel = GloabLineView(frame: CGRectMake(15, 0, SCREENWIDTH - 140, 0.5))
        self.contentView.addSubview(lineLabel)
        
        
        orderName = UILabel()
        orderName.text = "冉灿    18602035508"
        orderName.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        orderName.numberOfLines = 0
        orderName.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(orderName)
        
        orderAddress = UILabel()
        orderAddress.text = "朝阳区香河园小区西坝河中里35号楼二层207"
        orderAddress.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        orderAddress.numberOfLines = 0
        orderAddress.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(orderAddress)
        
        orderCountDownView = OrderCountDownView(frame: CGRectMake(91, 55, 68, 15))
        self.contentView.addSubview(orderCountDownView)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList) {
        if model.deliveryType == 1 {
            orderName.text = "\(model.address.name) \(model.address.mobileNum)"
            let str = "\(model.address.location)\(model.address.address)".stringByReplacingOccurrencesOfString(" ", withString: "")
            orderAddress.text = str
        }else if model.deliveryType == 2 {
            let str = "取票地点：\(model.ticket.selfGetTicketAddress)"
            orderName.text = str
            orderAddress.text = "取票时间：\(model.ticket.selfGetTicketDate)"
            orderName.snp_updateConstraints { (make) in
                make.height.equalTo(str.heightWithConstrainedWidth(str, font: App_Theme_PinFan_R_13_Font!, width: SCREENWIDTH - 30) + 3)
            }
        }else {
            let str = "取票地点：\(model.ticket.selfGetTicketAddress)"
            orderName.text = str
            orderAddress.text = "取票时间：\(model.ticket.selfGetTicketDate)"
            orderName.snp_updateConstraints { (make) in
                make.height.equalTo(str.heightWithConstrainedWidth(str, font: App_Theme_PinFan_R_13_Font!, width: SCREENWIDTH - 30) + 3)
            }
        }
        orderCountDownView.setUpDate("\(model.created)")
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            orderStatusWait.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.top.equalTo(self.contentView.snp_top).offset(30)
            })
            
            orderTime.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.top.equalTo(self.orderStatusWait.snp_bottom).offset(6)
            })
            
            orderImage.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-20)
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.size.equalTo(CGSizeMake(70, 82))
            })
            
            orderName.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(106)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.orderImage.snp_left).offset(-15)
            })
            
            orderAddress.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.orderName.snp_bottom).offset(1)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.orderImage.snp_left).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-28)
            })
            
            lineLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-83.5)
                make.right.equalTo(self.contentView.snp_right).offset(-125)
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
