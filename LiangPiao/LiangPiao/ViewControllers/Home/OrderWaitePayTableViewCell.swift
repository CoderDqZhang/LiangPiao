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
        orderStatusWait.font = Order_Status_Wait_Done_Font
        orderStatusWait.textColor = UIColor.init(hexString: Order_Status_Wait_Done_Color)
        orderStatusWait.text = "待付款"
        self.contentView.addSubview(orderStatusWait)
        
        orderTime = UILabel()
        orderTime.text = "剩余支付时间:"
        orderTime.textColor = UIColor.init(hexString: Home_Ticker_Descrip_Color)
        orderTime.font = Order_Status_Time_Font
        self.contentView.addSubview(orderTime)
        
        orderImage = UIImageView()
        orderImage.image = UIImage.init(named: "order_waitPay")
        self.contentView.addSubview(orderImage)
        
        
        lineLabel = GloabLineView(frame: CGRectMake(15, 0, SCREENWIDTH - 140, 0.5))
        self.contentView.addSubview(lineLabel)
        
        
        orderName = UILabel()
        orderName.text = "冉灿    18602035508"
        orderName.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
        orderName.font = Ticket_Detail_Name_Font
        self.contentView.addSubview(orderName)
        
        orderAddress = UILabel()
        orderAddress.text = "朝阳区香河园小区西坝河中里35号楼二层207"
        orderAddress.textColor = UIColor.init(hexString: Mine_Address_Name_Color)
        orderAddress.font = Ticket_Detail_Name_Font
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
        }else{
            orderName.text = "姓名：\(model.name)"
            orderAddress.text = "电话：\(model.phone)"
        }
        orderCountDownView.setUpDate("\(model.created)")
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
            })
            
            orderAddress.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.orderName.snp_bottom).offset(1)
                make.left.equalTo(self.contentView.snp_left).offset(15)
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
