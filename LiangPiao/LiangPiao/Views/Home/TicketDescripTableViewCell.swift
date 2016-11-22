//
//  TicketDescripTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketDescripTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLocation:UILabel!
    var ticketStatus:GlobalTicketStatus!
    var appTicketState:UILabel!
    var lineLabel:GloabLineView!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        ticketPhoto = UIImageView()
        ticketPhoto.layer.masksToBounds = true
        ticketPhoto.layer.cornerRadius = 3
        ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover")
        self.contentView.addSubview(ticketPhoto)
        
        ticketTitle = UILabel()
        ticketTitle.text = "万有音乐系 陈粒《小梦大半》2016巡回演唱会"
        UILabel.changeLineSpaceForLabel(ticketTitle, withSpace: 3.0)
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
        
        appTicketState = UILabel()
        appTicketState.text = "全部在售门票，100%保真，安全交易，无票赔付"
        appTicketState.textColor = UIColor.init(hexString: APP_State_Ticket_Color)
        appTicketState.font = APP_State_Ticket_Font!
        appTicketState.numberOfLines = 0
        UILabel.changeLineSpaceForLabel(appTicketState, withSpace: 3.0)
        self.contentView.addSubview(appTicketState)
        
        ticketStatus = GlobalTicketStatus(frame: CGRectZero, titles: ["9.6折","预售中","最后5张"], types: [3])
        self.addSubview(ticketStatus)
        
        lineLabel = GloabLineView(frame: CGRectMake(15, 139.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketPhoto.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
                make.width.equalTo(110)
            })
            
            ticketTitle.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(17)
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
            
            appTicketState.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-17)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(11)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketStatus.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.appTicketState.snp_top).offset(-7)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.height.equalTo(16)
            })
            
            lineLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-0.5)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
