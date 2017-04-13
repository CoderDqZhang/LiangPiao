//
//  OrderPayTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderPayTableViewCell: UITableViewCell {

    var lineLabel:GloabLineView!
    var receiptsLabel:UILabel!
    var discountCoupon:UILabel!
    var packingFee:UILabel!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        let receipts = self.createLabel(CGRect(x: 15, y: 25, width: 50, height: 17), name:"代收票款")
        self.contentView.addSubview(receipts)
        
        let discount = self.createLabel(CGRect(x: 15, y: 57, width: 50, height: 17), name:"优惠券")
        self.contentView.addSubview(discount)
        
        let packing = self.createLabel(CGRect(x: 15, y: 89, width: 50, height: 17), name:"配送费")
        self.contentView.addSubview(packing)
        
        receiptsLabel = self.createLabel(CGRect(x: SCREENWIDTH - 180, y: 25, width: 165, height: 17),name: "360 元")
        receiptsLabel.textAlignment = .right
        self.contentView.addSubview(receiptsLabel)
        
        discountCoupon = self.createLabel(CGRect(x: SCREENWIDTH - 180, y: 57, width: 165, height: 17),name: "0.00 元")
        discountCoupon.textAlignment = .right
        self.contentView.addSubview(discountCoupon)
        
        packingFee = self.createLabel(CGRect(x: SCREENWIDTH - 180, y: 89, width: 165, height: 17),name: "8.00 元")
        packingFee.textAlignment = .right
        self.contentView.addSubview(packingFee)
        
        lineLabel = GloabLineView(frame: CGRect(x: 15, y: 124.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(_ model:OrderList) {
        let doubleMuch = Double(Double(model.remainCount) * Double(model.ticket.price)) * 100
        let much = "\(doubleMuch)".muchType("\((doubleMuch))")
        let deliveryPrice = "\(model.deliveryPrice)".muchType("\((model.deliveryPrice)!)")
        receiptsLabel.text = "\((much)) 元"
        packingFee.text = "\((deliveryPrice)) 元"
    }
    
    func createLabel(_ frame:CGRect,name:String) -> UILabel {
        let label = UILabel(frame:frame)
        label.font = App_Theme_PinFan_R_12_Font
        label.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        label.text = name
        return label
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
