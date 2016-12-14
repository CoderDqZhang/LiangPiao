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
        
        pickUpLocation = UILabel()
        pickUpLocation.text = "取票地点：朝阳区香河园小区西坝河中里35号楼二层207"
        pickUpLocation.numberOfLines = 0
        pickUpLocation.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        pickUpLocation.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(pickUpLocation)
        
        pickUpTime = UILabel()
        pickUpTime.text = "取票地点：朝阳区香河园小区西坝河中里35号楼二层207"
        pickUpTime.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        pickUpTime.numberOfLines = 0
        pickUpTime.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(pickUpTime)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList){
        orderStatusDone.text = model.statusDesc
        if model.deliveryType == 1 {
            pickUpLocation.text = "\(model.address.name) \(model.address.mobileNum)"
            let str = "\(model.address.location)\(model.address.address)".stringByReplacingOccurrencesOfString(" ", withString: "")
            pickUpTime.text = str
        }else if model.deliveryType == 2 {
            let str = "取票地点：\(model.ticket.sceneGetTicketAddress)"
            pickUpLocation.snp_updateConstraints { (make) in
                make.height.equalTo(str.heightWithConstrainedWidth(str, font: App_Theme_PinFan_R_13_Font!, width: SCREENWIDTH - 30) + 3)
            }
            pickUpLocation.text = str
            pickUpTime.text = "取票时间：\(model.ticket.sceneGetTicketDate)"
        }else {
//            pickUpLocation.text = "取票地点：取票地点：朝阳区香河园小区西坝河中里35号楼二层207取票地点：朝阳区香河园小区西坝河中里35号楼二层207取票地点：朝阳区香河园小区西坝河中里35号楼二层207取票地点：朝阳区香河园小区西坝河中里35号楼二层207"
            let str = "取票地点：\(model.ticket.selfGetTicketAddress)"
            pickUpLocation.text = str
            pickUpTime.text = "取票时间：\(model.ticket.selfGetTicketDate)"
            pickUpLocation.snp_updateConstraints { (make) in
                make.height.equalTo(str.heightWithConstrainedWidth(str, font: App_Theme_PinFan_R_13_Font!, width: SCREENWIDTH - 30) + 3)
            }
        }
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            pickUpTime.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-28)
            })
            
            pickUpLocation.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.pickUpTime.snp_top).offset(-1)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            orderStatusDone.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.pickUpLocation.snp_top).offset(-10)
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
