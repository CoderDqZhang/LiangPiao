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
        orderNumber.text = "订单号：2877800028"
        orderNumber.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        orderNumber.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(orderNumber)
        
        orderStatus = UILabel()
        orderStatus.text = "已完成"
        orderStatus.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        orderStatus.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(orderStatus)
        
        lineLabel = GloabLineView(frame: CGRectMake(15, self.contentView.bounds.size.height - 0.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList) {
        orderStatus.text = model.statusDesc

        if model.status == 0 || model.status == 7 || model.status == 3{
            orderStatus.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        }else{
            orderStatus.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        }
        orderNumber.text = "订单号：\(model.id)"
    }
    
    func setSellData(model:OrderList) {
        orderStatus.text = model.supplierStatusDesc
        
        if model.status == 0 || model.status == 7 || model.status == 3{
            orderStatus.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        }else{
            orderStatus.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        }
        orderNumber.text = "订单号：\(model.id)"
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
