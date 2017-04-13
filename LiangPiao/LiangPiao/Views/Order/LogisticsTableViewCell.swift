//
//  LogisticsTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/25.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class LogisticsTableViewCell: UITableViewCell {

    var titleInfo:UILabel!
    var deliveryType:UILabel!
    var deliveryAddress:UILabel!
    
    var didMakeContraints:Bool = false
    
    var linLabel:GloabLineView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        titleInfo = UILabel()
        titleInfo.text = "收货信息"
        titleInfo.font = App_Theme_PinFan_M_13_Font
        titleInfo.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(titleInfo)
        
        deliveryType = UILabel()
        deliveryType.font = App_Theme_PinFan_R_13_Font
        deliveryType.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        self.contentView.addSubview(deliveryType)
        
        deliveryAddress = UILabel()
        deliveryAddress.font = App_Theme_PinFan_R_13_Font
        deliveryAddress.numberOfLines = 0
        deliveryAddress.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        self.contentView.addSubview(deliveryAddress)
        
        linLabel = GloabLineView(frame: CGRect(x: 15, y: 0, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(linLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpData(_ model:DeverliyModel, info:String) {
        titleInfo.text = info
        deliveryType.text = "配送方式：快递到付"
        deliveryAddress.text = "快递单号：\((model.logisticCode)!)"
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            
            titleInfo.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(20)
            })
            
            deliveryType.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.titleInfo.snp.bottom).offset(8)
            })
            
            deliveryAddress.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.deliveryType.snp.bottom).offset(2)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
            })
            
            self.didMakeContraints = true
            
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
