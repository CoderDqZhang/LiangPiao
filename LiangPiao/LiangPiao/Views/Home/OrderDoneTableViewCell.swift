//
//  OrderDoneTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderDoneTableViewCell: UITableViewCell {

    var orderStatusDone:UILabel!
    var pickUpLocation:UILabel!
    var pickUpTime:UILabel!
    var packUpInfo:UILabel!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        orderStatusDone = UILabel()
        orderStatusDone.text = "已完成"
        orderStatusDone.font = App_Theme_PinFan_M_16_Font
        orderStatusDone.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.contentView.addSubview(orderStatusDone)
        
        pickUpLocation = self.createLabel(CGRectMake(15, 58, SCREENWIDTH - 15, 18), text: "取票地点：朝阳区香河园小区西坝河中里35号楼二层207")
        self.contentView.addSubview(pickUpLocation)
        
        pickUpTime = self.createLabel(CGRectMake(15, 77, SCREENWIDTH - 15, 18), text: "取票时间：周一至周五 08:30 - 20:30")
        self.contentView.addSubview(pickUpTime)
        
        self.updateConstraintsIfNeeded()
    }
    
    func createLabel(frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.font = App_Theme_PinFan_R_13_Font
        label.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        label.text = text
        return label
    }
    
    func setData(model:OrderList){
        orderStatusDone.text = model.statusDesc
        if model.deliveryType == 1 {
            pickUpLocation.text = "\(model.address.name) \(model.address.mobileNum)"
            let str = "\(model.address.location)\(model.address.address)".stringByReplacingOccurrencesOfString(" ", withString: "")
            pickUpTime.text = str
        }else{
            pickUpLocation.text = "姓名：\(model.name)"
            pickUpTime.text = "电话：\(model.phone)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            orderStatusDone.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.top.equalTo(self.contentView.snp_top).offset(25)
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
