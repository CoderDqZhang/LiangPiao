//
//  RecommendTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import SDWebImage

class RecommendTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLocation:UILabel!
    var ticketMuch:UILabel!
    var ticketmMuch:UILabel!
    var ticketStatus:GlobalTicketStatus!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        ticketPhoto = UIImageView()
        ticketPhoto.layer.cornerRadius = 3
        ticketPhoto.layer.masksToBounds = true
        ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover")
        self.contentView.addSubview(ticketPhoto)
        
        ticketTitle = UILabel()
        ticketTitle.text = "万有音乐系 陈粒《小梦大半》2016巡回演唱会"
        ticketTitle.numberOfLines = 0
        ticketTitle.textColor = UIColor.init(hexString: Home_Recommend_Title_Color)
        ticketTitle.font = Home_Recommend_Title_Font
        self.contentView.addSubview(ticketTitle)

        ticketTime = UILabel()
        ticketTime.text = "2016.10.14 - 2016.11.28"
        ticketTime.textColor = UIColor.init(hexString: Home_Recommend_Time_Color)
        ticketTime.font = Home_Recommend_Time_Font
        self.contentView.addSubview(ticketTime)
        
        ticketLocation = UILabel()
        ticketLocation.text = "展览馆剧场"
        ticketLocation.textColor = UIColor.init(hexString: Home_Recommend_Time_Color)
        ticketLocation.font = Home_Recommend_Time_Font
        self.contentView.addSubview(ticketLocation)
        
        ticketmMuch = UILabel()
        ticketmMuch.text = "元起"
        ticketmMuch.textColor = UIColor.init(hexString: Home_Recommend_mMuch_Color)
        ticketmMuch.font = Home_Recommend_mMuch_Font
        self.contentView.addSubview(ticketmMuch)
        
        ticketMuch = UILabel()
        ticketMuch.text = "280"
        ticketMuch.textColor = UIColor.init(hexString: Home_Recommend_Much_Color)
        ticketMuch.font = Home_Recommend_Much_Font
        self.contentView.addSubview(ticketMuch)
        
        
        ticketStatus = GlobalTicketStatus(frame: CGRectZero, titles: ["9.6折","最后5张","预售中"], types: [3])
        self.addSubview(ticketStatus)
        
        let lineLabel = GloabLineView(frame: CGRectMake(15, 139.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketPhoto.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(15)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-15)
                make.width.equalTo(82)
            })
            
            ticketTitle.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(13)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })

            ticketTime.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.ticketTitle.snp_bottom).offset(6)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.height.equalTo(14)
            })

            ticketLocation.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.ticketTime.snp_bottom).offset(1)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.height.equalTo(14)
            })

            ticketmMuch.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-24)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-13)
                make.size.equalTo(CGSizeMake(22, 14))
            })

            ticketMuch.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-13  )
                make.right.equalTo(self.ticketmMuch.snp_left).offset(-4)
                make.height.equalTo(21)
            })
            
            ticketStatus.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-15)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.height.equalTo(16)
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
