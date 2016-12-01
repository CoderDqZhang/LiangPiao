
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
        self.addSubview(noneImageView)
        
        noneTitle = UILabel()
        noneTitle.text = "还没有符合条件的门票"
        noneTitle.textColor = UIColor.init(hexString: Home_Ticket_None_Color)
        noneTitle.font = Home_Ticket_None_Font
        self.contentView.addSubview(noneTitle)
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            noneImageView.snp_makeConstraints(closure: { (make) in
                make.size.equalTo(CGSizeMake(58, 63))
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(-25)
            })
            
            noneTitle.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.noneImageView.snp_bottom).offset(22)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
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
