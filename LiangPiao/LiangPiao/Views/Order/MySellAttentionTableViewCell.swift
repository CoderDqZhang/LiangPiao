//
//  MySellAttentionTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellAttentionTableViewCell: UITableViewCell {

    var attentionDec:UILabel!
    var attentionImageView:UIImageView!
    var attentionLineView:UIImageView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        attentionDec = UILabel()
        attentionDec.text = "售卖价格：售价过高，当前区域平均售价 680 元"
        attentionDec.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        let strArray = attentionDec.text?.components(separatedBy: " ")
        let strAttribute = NSMutableAttributedString.init(string: attentionDec.text!)
        strAttribute.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_4BD4C5_Color)], range: NSRange.init(location: strArray![0].length + 1, length: strArray![1].length))

        attentionDec.attributedText = strAttribute
        attentionDec.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(attentionDec)
        
        attentionImageView = UIImageView()
        attentionImageView.image = UIImage.init(named: "Icon_Average_Price")
        self.contentView.addSubview(attentionImageView)
        
        attentionLineView = UIImageView()
        attentionLineView.image = UIImage.init(named: "Line")
        
        self.contentView.addSubview(attentionLineView)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setMuchLabelText(_ text:String){
//        muchLabel.text = text
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            attentionImageView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(2)
            })
            
            attentionDec.snp.makeConstraints({ (make) in
                make.left.equalTo(self.attentionImageView.snp.right).offset(8)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(2)
            })
            
            attentionLineView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.height.equalTo(4)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            self.didMakeConstraints = true
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
