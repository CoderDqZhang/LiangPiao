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
        self.titleLabel.text = ""
        titleLabel.font = Home_Ticker_NomalPrice_Font
        titleLabel.textColor = UIColor.init(hexString: TablaBarItemTitleNomalColor)
        self.contentView.addSubview(titleLabel)
        
        lineLable = GloabLineView(frame: CGRectMake(15,0,SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLable)
        
        self.updateConstraintsIfNeeded()
    }
    
    func hideLineLabel() {
        self.lineLable.hidden = true
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            lineLable.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
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
