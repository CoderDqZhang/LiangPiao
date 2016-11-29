//
//  OrderNumberTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderNumberTableViewCell: UITableViewCell {

    var orderNumber:UILabel!
    var orderStatus:UILabel!
    var lineLabel:GloabLineView!
    var didMakeContraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        orderNumber = UILabel()
        orderNumber.text = "订单编号：2877800028"
        orderNumber.textColor = UIColor.init(hexString: Order_List_Number_Color)
        orderNumber.font = Order_List_Number_Font
        self.contentView.addSubview(orderNumber)
        
        orderStatus = UILabel()
        orderStatus.text = "已完成"
        orderStatus.textColor = UIColor.init(hexString: Order_List_Done_Color)
        orderStatus.font = Order_List_Done_Font
        self.contentView.addSubview(orderStatus)
        
        lineLabel = GloabLineView(frame: CGRectMake(15, self.contentView.bounds.size.height - 0.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList) {
        if model.status == 0 {
            orderStatus.text = "待付款"
            orderStatus.textColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        }else{
            orderStatus.text = "已完成"
            orderStatus.textColor = UIColor.init(hexString: Order_List_Done_Color)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            
            orderNumber.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            orderStatus.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            lineLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
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
