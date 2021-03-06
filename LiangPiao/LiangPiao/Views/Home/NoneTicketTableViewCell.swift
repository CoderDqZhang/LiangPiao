
//
//  NoneTicketTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 30/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class NoneTicketTableViewCell: UITableViewCell {

    var noneImageView:UIImageView!
    var noneTitle:UILabel!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        noneImageView = UIImageView()
        noneImageView.image = UIImage.init(named: "Icon_Default")
        self.contentView.addSubview(noneImageView)
        
        noneTitle = UILabel()
        noneTitle.text = "还没有符合条件的门票"
        noneTitle.textColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
        noneTitle.font = App_Theme_PinFan_R_15_Font
        self.contentView.addSubview(noneTitle)
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            noneImageView.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize.init(width: 58, height: 63))
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(-25)
            })
            
            noneTitle.snp.makeConstraints({ (make) in
                make.top.equalTo(self.noneImageView.snp.bottom).offset(22)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
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
