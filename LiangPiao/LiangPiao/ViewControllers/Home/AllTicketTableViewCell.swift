//
//  AllTicketTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 12/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class AllTicketTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    
    var lineLable:GloabLineView!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        self.titleLabel.text = "查看全部"
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        self.contentView.addSubview(titleLabel)
        
        lineLable = GloabLineView(frame: CGRect(x: 15,y: 0,width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    func hideLineLabel() {
        self.lineLable.isHidden = true
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            lineLable.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-0.5)
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
