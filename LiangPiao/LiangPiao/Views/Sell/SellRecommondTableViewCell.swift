//
//  SellRecommondTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SellRecommondTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLocation:UILabel!
    var ticketMuch:UILabel!
    var ticketmMuch:UILabel!
    var sellButton:UIButton!
    
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
        UILabel.changeLineSpaceForLabel(ticketTitle, withSpace: TitleLineSpace)
        ticketTitle.numberOfLines = 0
        ticketTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        ticketTitle.font = App_Theme_PinFan_R_15_Font
        self.contentView.addSubview(ticketTitle)
        
        ticketTime = UILabel()
        ticketTime.text = "2016.10.14 - 2016.11.28"
        ticketTime.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketTime.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketTime)
        
        ticketLocation = UILabel()
        ticketLocation.text = "展览馆剧场"
        ticketLocation.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketLocation.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketLocation)
        
        ticketmMuch = UILabel()
        ticketmMuch.text = "元"
        ticketmMuch.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        ticketmMuch.font = App_Theme_PinFan_R_10_Font
        self.contentView.addSubview(ticketmMuch)
        
        ticketMuch = UILabel()
        ticketMuch.text = "80-360"
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        ticketMuch.font = App_Theme_PinFan_R_18_Font
        self.contentView.addSubview(ticketMuch)
        
        sellButton = UIButton(type: .Custom)
        sellButton.setTitle("卖票", forState: .Normal)
        sellButton.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
        sellButton.titleLabel?.font = App_Theme_PinFan_R_12_Font
        sellButton.layer.cornerRadius = 2.0
        sellButton.layer.borderWidth = 1.0
        sellButton.layer.masksToBounds = true
        sellButton.userInteractionEnabled = false
        sellButton.setTitleColor(UIColor.init(hexString: App_Theme_4BD4C5_Color), forState: .Normal)
        self.contentView.addSubview(sellButton)
        
        let lineLabel = GloabLineView(frame: CGRectMake(15, 139.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    func setData(model:TicketShowModel) {
        ticketPhoto.sd_setImageWithURL(NSURL.init(string: model.cover), placeholderImage: UIImage.init(named: "Feeds_Default_Cover")) { (image, error, cacheType, url) in
        }
        ticketTitle.text = model.title
        UILabel.changeLineSpaceForLabel(ticketTitle, withSpace: TitleLineSpace)
        UILabel.changeLineSpaceForLabel(ticketTitle, withSpace: TitleLineSpace)
        ticketLocation.text = model.venue.name
        ticketTime.text = model.showDate
        if model.maxPrice == nil  {
            ticketMuch.text = "\(model.minPrice)"
        }else{
            if model.minPrice == 0 && model.maxPrice == 0 {
                ticketMuch.text = "0"
            }else{
                if model.minPrice == model.maxPrice {
                    ticketMuch.text = "\(model.minPrice)"
                }else{
                    ticketMuch.text = "\(model.minPrice)-\(model.maxPrice)"
                }
            }
        }
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
                make.left.equalTo(self.ticketMuch.snp_right).offset(4)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-14)
            })
            
            ticketMuch.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-11)
                make.left.equalTo(self.ticketPhoto.snp_right).offset(12)
            })
            
            sellButton.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-15)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.size.equalTo(CGSizeMake(50, 25))
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
