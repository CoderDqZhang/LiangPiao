//
//  CofimTicketTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class CofimTicketTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLocation:UILabel!
    var ticketMuch:UILabel!
    var ticketRow:UILabel!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.setUpView()
    }
    
    func setUpView() {
        ticketPhoto = UIImageView()
        ticketPhoto.layer.cornerRadius = 3
        ticketPhoto.layer.masksToBounds = true
        ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover_02")
        self.contentView.addSubview(ticketPhoto)
        
        ticketTitle = UILabel()
        ticketTitle.text = "万有音乐系 陈粒《小梦大半》2016巡回演唱会"
        ticketTitle.numberOfLines = 0
        UILabel.changeLineSpaceForLabel(ticketTitle, withSpace: TitleLineSpace)
        ticketTitle.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        ticketTitle.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(ticketTitle)
        
        ticketTime = UILabel()
        ticketTime.text = "时间：2016.12.18 20:25"
        ticketTime.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketTime.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketTime)
        
        ticketLocation = UILabel()
        ticketLocation.text = "场馆：大隐剧院 朝阳区光华路9号世贸天阶 C 座时尚大厦5楼"
        UILabel.changeLineSpaceForLabel(ticketLocation, withSpace: 3.0)
        ticketLocation.numberOfLines = 0
        ticketLocation.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketLocation.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketLocation)
        
        ticketMuch = UILabel()
        ticketMuch.text = "票面：960（480x2上下本联票）x2"
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketMuch.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketMuch)
        
        ticketRow = UILabel()
        ticketRow.text = "座位：优先择座"
        ticketRow.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketRow.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketRow)
        
        
        lineLabel = GloabLineView(frame: CGRectMake(15, 149.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    func setData(model:TicketShowModel, ticketModel:TicketList, sessionModel:ShowSessionModel, remainCount:String) {
        ticketPhoto.sd_setImageWithURL(NSURL.init(string: model.cover), placeholderImage: UIImage.init(named: "Feeds_Default_Cover_02")) { (image, error, cacheType, url) in
        }
        ticketTitle.text = model.title
        UILabel.changeLineSpaceForLabel(ticketTitle, withSpace: TitleLineSpace)
        ticketTime.text = "时间：\(sessionModel.name)"
        ticketLocation.text = "场馆：\(model.venue.name)"
        ticketMuch.text = "票面：\(ticketModel.originalTicket.name)"
        var str = ""
        if ticketModel.region == "" {
            str = "优先择座"
        }else if ticketModel.row == "" {
            str = "\(ticketModel.region)"
        }else {
            str = "\(ticketModel.region) \(ticketModel.row)排"
        }
        ticketRow.text = "座位：\(str)"
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketPhoto.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
                make.width.equalTo(82)
            })
            
            ticketTitle.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(17)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketTime.snp_makeConstraints(closure: { (make) in
                make.top.greaterThanOrEqualTo(self.ticketTitle.snp_bottom).offset(-2)
                make.bottom.equalTo(self.ticketLocation.snp_top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketLocation.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.ticketMuch.snp_top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
            })
            
            ticketMuch.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.ticketRow.snp_top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
            })
            
            ticketRow.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
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
