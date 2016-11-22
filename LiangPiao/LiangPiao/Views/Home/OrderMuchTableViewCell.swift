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
        muchInfoLabel.font = Home_Ticker_Tools_Table_Font
        muchInfoLabel.textColor = UIColor.init(hexString: Home_Ticker_Tools_Table_sColor)
        self.contentView.addSubview(muchInfoLabel)
        
        muchLabel = UILabel()
        muchLabel.text = "688.00 元"
        let attributeString = NSMutableAttributedString(string: muchLabel.text!)
        attributeString.addAttribute(NSFontAttributeName,
                                     value: Home_PayView_WaitPay_Much_Font!,
                                     range: NSMakeRange(0,muchLabel.text!.length - 1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: Home_ReciveView_Label_Nomal_nColor),
                                     range: NSMakeRange(0, muchLabel.text!.length - 1))
        attributeString.addAttribute(NSFontAttributeName,
                                     value: Home_PayView_MuchLabel_Font!,
                                     range: NSMakeRange(muchLabel.text!.length - 1,1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: Home_Ticker_Descrip_Color),
                                     range: NSMakeRange(muchLabel.text!.length - 1,1))
        muchLabel.attributedText = attributeString
        self.contentView.addSubview(muchLabel)
        
        self.updateConstraintsIfNeeded()
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
