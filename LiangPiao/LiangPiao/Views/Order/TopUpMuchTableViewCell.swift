//
//  TopUpMuchTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TopUpMuchTableViewCell: UITableViewCell {

    var muchLabel:UILabel!
    var muchTextField:UITextField!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        muchLabel = UILabel()
        muchLabel.text = "充值金额 (元)："
        muchLabel.font = App_Theme_PinFan_R_13_Font
        muchLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(muchLabel)
        
        muchTextField = UITextField()
        let text = "0.00"
        muchTextField.keyboardType = .NumberPad
        muchTextField.placeholder = text
        muchTextField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchTextField.font = App_Theme_PinFan_R_28_Font
        muchTextField.textAlignment = .Right
        muchTextField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        muchTextField.attributedPlaceholder = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:App_Theme_PinFan_R_28_Font!,NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)])
        self.contentView.addSubview(muchTextField)
        
        let lineLabel = GloabLineView(frame: CGRect.init(x: 15, y: 99.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            muchLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.width.equalTo(95)
            })
            
            muchTextField.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.height.equalTo(34)
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
