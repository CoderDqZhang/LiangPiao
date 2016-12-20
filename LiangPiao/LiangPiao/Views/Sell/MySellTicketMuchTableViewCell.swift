//
//  MySellTicketMuchTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 15/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellTicketMuchTableViewCell: UITableViewCell {

    var ticketTitle:UILabel!
    var muchTextField:UITextField!
    var instroduct:UILabel!
    var muchIntroduct:UILabel!
//    var button:CustomButton!
    var didMakeContraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        ticketTitle = UILabel()
        ticketTitle.text = "单张售价 (元) "
        ticketTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        ticketTitle.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(ticketTitle)
        
//        button = CustomButton.init(frame: CGRectZero, title: "使用建议价格", tag: nil, titleFont: App_Theme_PinFan_M_12_Font!, type: .withNoBoarder) { (tag) in
//            
//        }
//        self.contentView.addSubview(button)
        
        muchTextField = UITextField()
        muchTextField.placeholder = "0"
        let placeholder = NSMutableAttributedString.init(string: "0")
        placeholder.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_DDE0E5_Color)], range: NSRange.init(location: 0, length: 1))
        placeholder.addAttributes([NSFontAttributeName:App_Theme_PinFan_R_30_Font!], range: NSRange.init(location: 0, length: 1))
        muchTextField.keyboardType = .NumberPad
        muchTextField.attributedPlaceholder = placeholder
        muchTextField.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchTextField.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        muchTextField.font = App_Theme_PinFan_R_30_Font
        self.contentView.addSubview(muchTextField)
        
        instroduct = UILabel()
        instroduct.text = "良票优先显示相同区域更低的票价"
        instroduct.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        instroduct.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(instroduct)
        
//        muchIntroduct = UILabel()
//        let str = "当前区域平均售价 280.00 元，建议售价 220.00 元"
//        muchIntroduct.text = str
//        muchIntroduct.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
//        let strArray = str.componentsSeparatedByString(" ")
//        let attribute = NSMutableAttributedString.init(string: str)
//        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_4BD4C5_Color)], range: NSRange.init(location: strArray[0].length + strArray[1].length + strArray[2].length + 3, length: strArray[3].length))
//        muchIntroduct.attributedText = attribute
//        muchIntroduct.font = App_Theme_PinFan_R_12_Font
//        self.contentView.addSubview(muchIntroduct)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            
            ticketTitle.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.top.equalTo(self.contentView.snp_top).offset(21)
            })
            
//            button.snp_makeConstraints { (make) in
//                make.right.equalTo(self.contentView.snp_right).offset(-15)
//                make.top.equalTo(self.contentView.snp_top).offset(15)
//            }
            
            muchTextField.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.top.equalTo(self.ticketTitle.snp_bottom).offset(20)
            })
            
            instroduct.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.top.equalTo(self.muchTextField.snp_bottom).offset(20)
            })
            
//            muchIntroduct.snp_makeConstraints(closure: { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(15)
//                make.top.equalTo(self.instroduct.snp_bottom).offset(2)
//            })
            
            self.didMakeContraints = true
            
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
