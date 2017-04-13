//
//  TopUpTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

typealias WithDrawTableViewCellClouse = () ->Void
class WithDrawTableViewCell: UITableViewCell {

    var muchLabel:UILabel!
    var muchTextField:UITextField!
    var topUpButton:CustomButton!
    var withDrawTableViewCellClouse:WithDrawTableViewCellClouse!
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
        
        self.contentView.addSubview(muchTextField)
        
        topUpButton = CustomButton.init(frame: CGRect.zero, title: "全部提现", tag: nil, titleFont: App_Theme_PinFan_R_12_Font!, type: .withNoBoarder, pressClouse: { (tag) in
            if self.withDrawTableViewCellClouse != nil {
                self.withDrawTableViewCellClouse()
            }
        })
        self.contentView.addSubview(topUpButton)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setPlachText(_ text:String){
        let text = "最多可提：\(text)元"
        muchTextField.placeholder = text
        muchTextField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchTextField.font = App_Theme_PinFan_R_13_Font
        muchTextField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        muchTextField.attributedPlaceholder = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:App_Theme_PinFan_R_13_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)])
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.width.equalTo(66)
            })
            
            muchTextField.snp.makeConstraints({ (make) in
                make.left.equalTo(self.muchLabel.snp.right).offset(28)
                make.right.equalTo(self.topUpButton.snp.left).offset(-7)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            topUpButton.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.height.equalTo(49)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
