//
//  MySellIntrouductTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 08/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellIntrouductTableViewCell: UITableViewCell {

    var ticketMuch:UILabel!
    var attentionLineView:UIImageView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.setUpView()
    }
    
    func setUpView() {
        
        attentionLineView = UIImageView()
        attentionLineView.image = UIImage.init(named: "Line")
        self.contentView.addSubview(attentionLineView)
        
        ticketMuch = UILabel()
        let str = "良票优先显示相同区域更低的票价\n当前区域平均售价 280.00 元，建议售价 220.00 元"
        ticketMuch.text = str
        ticketMuch.numberOfLines = 0
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketMuch.font = App_Theme_PinFan_R_13_Font
        let strArray = str.components(separatedBy: " ")
        let attributed = NSMutableAttributedString.init(string: ticketMuch.text!)
        attributed.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_4BD4C5_Color)], range: NSRange.init(location: strArray[0].length + 1, length: strArray[1].length))
        attributed.addAttributes([NSForegroundColorAttributeName:UIColor.init(hexString: App_Theme_4BD4C5_Color)], range: NSRange.init(location: strArray[0].length + strArray[1].length + strArray[2].length + 3, length: strArray[3].length))
        ticketMuch.attributedText = attributed
        self.contentView.addSubview(ticketMuch)
        
        
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            attentionLineView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(26)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.height.equalTo(4)
            })
            
            ticketMuch.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-24)
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
