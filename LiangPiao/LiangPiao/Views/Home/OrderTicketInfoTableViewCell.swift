//
//  OrderTicketInfoTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderTicketInfoTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketMuch:UILabel!
    var ticketRow:UILabel!
    var ticketAllMuch:UILabel!
    
    var tickType:OrderType = .orderWaitPay
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(hexString: App_Theme_F6F7FA_Color)
        self.setUpView()
    }
    
    func setUpView() {
        ticketPhoto = UIImageView()
        ticketPhoto.layer.cornerRadius = 3
        ticketPhoto.layer.masksToBounds = true
        ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover")
        self.contentView.addSubview(ticketPhoto)
        
        ticketTitle = UILabel()
        ticketTitle.text = "万有音乐系 陈粒《小梦大半》2016巡回演唱会"
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        ticketTitle.font = App_Theme_PinFan_R_15_Font
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTitle.numberOfLines = 0
        self.contentView.addSubview(ticketTitle)
        
        ticketTime = UILabel()
        ticketTime.text = "时间：2016.12.18 20:25"
        ticketTime.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketTime.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketTime)
        
        ticketMuch = UILabel()
        ticketMuch.text = "票面：960（480x2上下本联票）x2"
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketMuch.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketMuch)
        
        ticketRow = UILabel()
        ticketRow.text = "区域：看台一    座位：优先择座"
        ticketRow.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketRow.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketRow)
        
        ticketAllMuch = UILabel()
        ticketAllMuch.text = "实付金额：960"
        ticketAllMuch.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        ticketAllMuch.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketAllMuch)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    func setData(_ model:OrderList){
        if model.status == 0 {
            ticketPhoto.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-18)
            })
            ticketAllMuch.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-18)
            })
        }else{
            ticketPhoto.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-30)
            })
            ticketAllMuch.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-30)
            })
        }

        ticketPhoto.sd_setImage(with: URL.init(string: model.show.cover), placeholderImage: UIImage.init(named: "Feeds_Default_Cover"), options: .retryFailed, progress: { (start, end, url) in
            
        }) { (image, error, cacheType, url) in
            
        }
        ticketTitle.text = model.show.title
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTime.text = "时间：\((model.session.startTime)!)"
        ticketMuch.text = "票面：\((model.ticket.originalTicket.name)!) x \((model.remainCount)!)"
        if model.ticket.region == "" {
            ticketRow.text = "座位：随机"
        }else{
            let row = model.ticket.row == "" ? "随机":"\((model.ticket.row)!)排"
            ticketRow.text = "座位：\((model.ticket.region)!) \(row)"
        }
        ticketAllMuch.text = "实付金额：\((model.total)!)"
    }
    
    func setSellData(_ model:OrderList){
        ticketPhoto.snp.updateConstraints({ (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-19)
        })
        ticketAllMuch.snp.updateConstraints({ (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-19)
        })
        ticketPhoto.sd_setImage(with: URL.init(string: model.show.cover), placeholderImage: UIImage.init(named: "Feeds_Default_Cover"), options: .retryFailed, progress: { (start, end, url) in
            
        }) { (image, error, cacheType, url) in
            
        }
        ticketTitle.text = model.show.title
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTime.text = "时间：\((model.session.startTime)!)"
        ticketMuch.text = "票面：\((model.ticket.originalTicket.name)!)"
        if model.ticket.region == "" {
            ticketAllMuch.text = "座位：随机"
        }else{
            let row = model.ticket.row == "" ? "随机":"\((model.ticket.row)!)排"
            ticketAllMuch.text = "座位：\((model.ticket.region)!) \(row)"
        }
        ticketRow.text = "数量：\((model.remainCount)!)"
        
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketPhoto.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(20)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
                make.width.equalTo(82)
            })
            
            ticketTitle.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(17)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketTime.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketMuch.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketMuch.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketRow.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
            })
            
            ticketRow.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketAllMuch.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
            })
            
            ticketAllMuch.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-18)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
