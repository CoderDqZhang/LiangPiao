//
//  SetNomalAddressTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SetNomalAddressTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var switchBar:UISwitch!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel()
        titleLabel.text = "设为默认"
        titleLabel.font = App_Theme_PinFan_R_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(titleLabel)
        
        switchBar = UISwitch()
        switchBar.onTintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        switchBar.setOn(true, animated: true)
//        switchBar.tintColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        
        self.contentView.addSubview(switchBar)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            switchBar.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-15)
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
