//
//  OrderStatusMuchTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderStatusMuchTableViewCell: UITableViewCell {

    var muchLabel:UILabel!
    var muchInfoLabel:UILabel!
    var muchmLabel:UILabel!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        muchInfoLabel = UILabel()
        muchInfoLabel.text = "实付金额"
        muchInfoLabel.font = App_Theme_PinFan_R_12_Font
        muchInfoLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(muchInfoLabel)
        
        muchLabel = UILabel()
        muchLabel.font = App_Theme_PinFan_R_18_Font
        muchLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchLabel.text = "688.00"
        
        self.contentView.addSubview(muchLabel)
        
        muchmLabel = UILabel()
        muchmLabel.font = App_Theme_PinFan_R_12_Font
        muchmLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        muchmLabel.text = "元"
        
        self.contentView.addSubview(muchmLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList){
        let muchs = model.total * 100
        let much = "\(muchs)".muchType("\(muchs)")
        muchLabel.text = "\(much)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.muchmLabel.snp_left).offset(-6)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(3)
            })
            
            muchInfoLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(3)
            })
            
            muchmLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(3.5)
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
