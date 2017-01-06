//
//  OrderMuchTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderMuchTableViewCell: UITableViewCell {

    var muchLabel:UILabel!
    var muchmLabel:UILabel!
    var muchInfoLabel:UILabel!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        muchInfoLabel = UILabel()
        muchInfoLabel.text = "实付金额："
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
        
        self.contentView.addSubview(muchLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList){
        let much = "\(model.total)".muchType("\(model.total)")
        muchLabel.text = "\(much)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.muchmLabel.snp_left).offset(-3)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(3)
            })
            
            muchInfoLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.muchLabel.snp_left).offset(-2)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(3)
            })
            
            muchmLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(4)
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
