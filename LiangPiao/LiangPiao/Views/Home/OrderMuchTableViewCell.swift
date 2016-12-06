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
        muchLabel.text = "688.00 元"
        
        self.contentView.addSubview(muchLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(model:OrderList){
        muchLabel.text = "\(model.total).00 元"
        self.updataMuchTextAttribute()
    }
    
    func updataMuchTextAttribute(){
        let attributeString = NSMutableAttributedString(string: muchLabel.text!)
        attributeString.addAttribute(NSFontAttributeName,
                                     value: App_Theme_PinFan_R_18_Font!,
                                     range: NSMakeRange(0,muchLabel.text!.length - 1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: App_Theme_4BD4C5_Color),
                                     range: NSMakeRange(0, muchLabel.text!.length - 1))
        attributeString.addAttribute(NSFontAttributeName,
                                     value: App_Theme_PinFan_R_10_Font!,
                                     range: NSMakeRange(muchLabel.text!.length - 1,1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: App_Theme_BBC1CB_Color),
                                     range: NSMakeRange(muchLabel.text!.length - 1,1))
        muchLabel.attributedText = attributeString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            muchInfoLabel.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.muchLabel.snp_left).offset(-2)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
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
