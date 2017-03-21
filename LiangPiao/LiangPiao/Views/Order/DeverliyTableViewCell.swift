//
//  DeverliyTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class DeverliyTableViewCell: UITableViewCell {

    var leftLine:UILabel!
    var leftLabel:UILabel!
    var infoLabel:UILabel!
    var infoTitle:UILabel!
    var timeLabel:UILabel!
    
    var didMakeContraints:Bool = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        leftLine = UILabel()
        leftLine.backgroundColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
        self.contentView.addSubview(leftLine)
        
        leftLabel = UILabel()
        leftLabel.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        leftLabel.layer.cornerRadius = 4.5
        leftLabel.layer.borderWidth = 1
        leftLabel.layer.borderColor = UIColor.init(hexString: App_Theme_DDE0E5_Color).CGColor
        self.contentView.addSubview(leftLabel)
        
        infoTitle = UILabel()
        infoTitle.font = App_Theme_PinFan_R_13_Font
        infoTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(infoTitle)
        
        infoLabel = UILabel()
        infoLabel.text = "派件员 张永和 正在为您派件 18602230682"
        infoLabel.numberOfLines = 0
        infoLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        infoLabel.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(infoLabel)
        
        timeLabel = UILabel()
        timeLabel.text = "2017.02.06 20:35"
        timeLabel.font = App_Theme_PinFan_R_13_Font
        timeLabel.numberOfLines = 0
        timeLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        self.contentView.addSubview(timeLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpData(trac:Trace) {
        self.infoTitle.text = "物流追踪"
        self.infoLabel.text = trac.acceptStation
        self.timeLabel.text = trac.acceptTime
        
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            leftLine.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(0)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-5)
                make.left.equalTo(self.contentView.snp_left).offset(27)
                make.width.equalTo(1)
            })
            
            leftLabel.snp_makeConstraints(closure: { (make) in
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.left.equalTo(self.contentView.snp_left).offset(23)
                make.size.equalTo(CGSize.init(width: 9, height: 9))
            })
            
            infoTitle.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(10.5)
                make.left.equalTo(self.contentView.snp_left).offset(55)
            })
            
            infoLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.infoTitle.snp_bottom).offset(6)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.left.equalTo(self.contentView.snp_left).offset(55)
            })
            
            timeLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.infoLabel.snp_bottom).offset(2)
                make.left.equalTo(self.contentView.snp_left).offset(55)
                make.right.lessThanOrEqualTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
            })
            
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
