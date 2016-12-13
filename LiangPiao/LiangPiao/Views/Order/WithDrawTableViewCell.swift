//
//  TopUpTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class WithDrawTableViewCell: UITableViewCell {

    var muchLabel:UILabel!
    var muchTextField:UITextField!
    var topUpButton:CustomButton!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        muchLabel = UILabel()
        muchLabel.text = "提现金额"
        muchLabel.font = App_Theme_PinFan_R_13_Font
        muchLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(muchLabel)
        
        muchTextField = UITextField()
        let text = "最多可提：200.00元"
        muchTextField.placeholder = text
        muchTextField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchTextField.font = App_Theme_PinFan_R_15_Font
        muchTextField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        muchTextField.attributedPlaceholder = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:App_Theme_PinFan_R_13_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)])
        self.contentView.addSubview(muchTextField)
        
        topUpButton = CustomButton.init(frame: CGRectZero, title: "全部提现", tag: nil, titleFont: App_Theme_PinFan_R_12_Font!, type: .withNoBoarder, pressClouse: { (tag) in
            
        })
        self.contentView.addSubview(topUpButton)
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.width.equalTo(66)
            })
            
            muchTextField.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.muchLabel.snp_right).offset(24)
                make.right.equalTo(self.topUpButton.snp_left).offset(-7)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            topUpButton.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.height.equalTo(49)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
