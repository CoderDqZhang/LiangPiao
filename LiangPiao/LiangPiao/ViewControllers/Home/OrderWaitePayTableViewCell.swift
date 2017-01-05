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
    
        orderCountDownView = OrderCountDownView(frame: CGRectMake(91, 67, 68, 15))
        self.contentView.addSubview(orderCountDownView)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList) {
        orderStatusWait.text = model.statusDesc
        if model.status == 0 {
            orderTime.text = "剩余支付时间:"
            orderTime.font = App_Theme_PinFan_R_11_Font
            orderCountDownView.setUpDate("\(model.created)")
        }else if model.status == 2 {
            orderTime.text = "感谢您的购买，因未在规定时间内付款，故该订单已取消"
            orderTime.font = App_Theme_PinFan_R_12_Font
            orderCountDownView.hidden = true
        }
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            orderStatusWait.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.top.equalTo(self.contentView.snp_top).offset(42)
            })
            
            orderTime.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.top.equalTo(self.orderStatusWait.snp_bottom).offset(6)
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
