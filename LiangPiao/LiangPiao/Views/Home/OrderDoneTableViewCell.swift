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
        orderStatusDone.font = Order_Status_Wait_Done_Font
        orderStatusDone.textColor = UIColor.init(hexString: Order_Status_Wait_Done_Color)
        self.contentView.addSubview(orderStatusDone)
        
        pickUpLocation = self.createLabel(CGRectMake(15, 58, SCREENWIDTH - 15, 18), text: "取票地点：朝阳区香河园小区西坝河中里35号楼二层207")
        self.contentView.addSubview(pickUpLocation)
        
        pickUpTime = self.createLabel(CGRectMake(15, 77, SCREENWIDTH - 15, 18), text: "取票时间：周一至周五 08:30 - 20:30")
        self.contentView.addSubview(pickUpTime)
        
        packUpInfo = self.createLabel(CGRectMake(15, 96, SCREENWIDTH - 15, 18), text: "凭手机短信取票码取票，客服热线 400-636-2266")
        self.contentView.addSubview(packUpInfo)
        
        self.updateConstraintsIfNeeded()
    }
    
    func createLabel(frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.font = GlobalCell_Title_Font
        label.textColor = UIColor.init(hexString: GlobalCell_Title_Color)
        label.text = text
        return label
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
