//
//  TicketDetailInfoTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 21/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketDetailInfoTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketNumber:UILabel!
    var ticketMuch:UILabel!
    var ticketRow:UILabel!
    var lineLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
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
        ticketTitle.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        ticketTitle.font = App_Theme_PinFan_R_14_Font
        ticketTitle.numberOfLines = 0
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        self.contentView.addSubview(ticketTitle)
        
        ticketTime = UILabel()
        ticketTime.text = "时间：2016.12.18 20:25"
        ticketTime.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketTime.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketTime)
        
        ticketMuch = UILabel()
        ticketMuch.text = "票面：960（480x2上下本联票）x2"
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketMuch.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketMuch)
        
        ticketNumber = UILabel()
        ticketNumber.text = "时间：2016.12.18 20:25"
        ticketNumber.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketNumber.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketNumber)
        
        ticketRow = UILabel()
        ticketRow.text = "座位：优先择座"
        ticketRow.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketRow.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketRow)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 15, y: 148.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    func setData(_ model:OrderList){
        ticketPhoto.sd_setImage(with: URL.init(string: model.show.cover), placeholderImage: UIImage.init(named: "Feeds_Default_Cover_02"), options: .retryFailed, progress: { (start, end, url) in
            
        }) { (image, error, cacheType, url) in
            
        }
        ticketTitle.text = model.show.title
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTime.text = "时间：\((model.session.startTime)!)"
        ticketMuch.text = "票面：\((model.ticket.originalTicket.name)!)"
        ticketNumber.text = "数量：\((model.remainCount)!)"
        var str = ""
        if model.ticket.region == "" {
            str = "优先择座"
        }else if model.ticket.row == "" {
            str = "\((model.ticket.region)!)"
        }else {
            str = "\((model.ticket.region)!) \((model.ticket.row)!)排"
        }
        ticketRow.text = "座位：\(str)"
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
                make.bottom.equalTo(self.ticketNumber.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketNumber.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.ticketRow.snp.top).offset(-2)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketRow.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
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
