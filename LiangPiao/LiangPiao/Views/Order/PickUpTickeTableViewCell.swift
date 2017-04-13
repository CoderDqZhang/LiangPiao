//
//  PickUpTickeTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class PickUpTickeTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLocation:UILabel!
    var detailImage:UIImageView!
    var ticketStatusView:GlobalTicketStatus!
    var ticketNumber:UILabel!
    var ticketMuch:UILabel!
    var ticketmMuch:UILabel!
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
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTitle.numberOfLines = 0
        ticketTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        ticketTitle.font = App_Theme_PinFan_R_15_Font
        self.contentView.addSubview(ticketTitle)
        
        ticketStatusView = GlobalTicketStatus(frame: CGRect.zero, titles: ["售卖中","在售2张"], types: nil)
        self.contentView.addSubview(ticketStatusView)
        
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
        
        ticketNumber = UILabel()
        ticketNumber.text = "已售：0"
        ticketNumber.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketNumber.font = App_Theme_PinFan_R_12_Font!
        ticketNumber.numberOfLines = 0
        self.contentView.addSubview(ticketNumber)
        
        ticketMuch = UILabel()
        ticketMuch.text = "280-1288"
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        ticketMuch.font = App_Theme_PinFan_R_18_Font!
        ticketMuch.numberOfLines = 0
        self.contentView.addSubview(ticketMuch)
        
        ticketmMuch = UILabel()
        ticketmMuch.text = "元"
        ticketmMuch.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        ticketmMuch.font = App_Theme_PinFan_R_10_Font!
        ticketmMuch.numberOfLines = 0
        self.contentView.addSubview(ticketmMuch)
        
        detailImage = UIImageView()
        detailImage.image = UIImage.init(named: "Btn_More")
        self.contentView.addSubview(detailImage)
        
        lineLabel = GloabLineView(frame: CGRect(x: 15, y: 139.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setData(_ model:TicketShowModel, session:String, sellCount:String, soldCount:String, soldMuch:String){

        ticketPhoto.sd_setImage(with: URL.init(string: model.cover), placeholderImage: UIImage.init(named: "Feeds_Default_Cover"), options: .retryFailed, progress: { (start, end, url) in
            
        }) { (image, error, cacheType, url) in
            
        }
        ticketTitle.text = model.title
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTime.text = session
        ticketLocation.text = model.venue.name
        ticketMuch.text = soldMuch
        ticketNumber.text = "已售：\(soldCount)"
        self.setUpTicketStatues(sellCount)
            
    }
    
    func hiddenLindeLabel(){
        lineLabel.isHidden = true
    }
    
    func setUpTicketStatues(_ sellCount:String){
        let statuesArray:[String] = ["在售\(sellCount)张"]
        self.setUpStatuesView(statuesArray, types: nil)
    }
    
    func setUpStatuesView(_ titles:[String], types:NSArray?){
        if ticketStatusView == nil {
            ticketStatusView = GlobalTicketStatus(frame: CGRect.zero, titles: titles, types: types)
            self.contentView.addSubview(ticketStatusView)
            
            ticketStatusView.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketTitle.snp.bottom).offset(7)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.height.equalTo(16)
            })
            
            self.updateConstraintsIfNeeded()
        }else{
            ticketStatusView.setUpView(titles, types: types)
        }
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
            ticketPhoto.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(20)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
                make.width.equalTo(110)
            })
            
            ticketTitle.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(17)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketStatusView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.ticketTitle.snp.bottom).offset(7)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.height.equalTo(16)
            })
            
            ticketTime.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketLocation.snp.top).offset(-1)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.height.lessThanOrEqualTo(30)
                make.right.equalTo(self.contentView.snp.right).offset(-25)
            })
            
            ticketLocation.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketNumber.snp.top).offset(-1)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            detailImage.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(10)
            })
            
            ticketNumber.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketMuch.snp.top).offset(-9)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketMuch.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-17)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
            })
            
            ticketmMuch.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
                make.left.equalTo(self.ticketMuch.snp.right).offset(3)
            })
            
            lineLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-0.5)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
