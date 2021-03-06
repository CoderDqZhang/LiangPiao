//
//  RecommendTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 01/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import SDWebImage
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class RecommendTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLocation:UILabel!
    var ticketMuch:UILabel!
    var ticketmMuch:UILabel!
    var ticketStatusView:GlobalTicketStatus!
    
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
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
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
        ticketmMuch.text = "元起"
        ticketmMuch.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        ticketmMuch.font = App_Theme_PinFan_R_10_Font
        self.contentView.addSubview(ticketmMuch)
        
        ticketMuch = UILabel()
        ticketMuch.text = "280"
        ticketMuch.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        ticketMuch.font = App_Theme_PinFan_R_21_Font
        self.contentView.addSubview(ticketMuch)
        
        let lineLabel = GloabLineView(frame: CGRect(x: 15, y: 139.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    func setData(_ model:TicketShowModel) {
        ticketPhoto.sd_setImage(with: URL.init(string: model.cover), placeholderImage: UIImage.init(named: "Feeds_Default_Cover"), options: SDWebImageOptions.retryFailed, progress: { (start, end, url) in
            
        }) { (image, error, cache, url) in
            
        }
        ticketTitle.text = model.title
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketLocation.text = model.venue.name
        if model.ticketStatus != 0 || model.minPrice == 0 {
            let mMuch = model.remainCount == 0 || model.minPrice == 0 ? "暂时缺票" : "元起"
            ticketmMuch.text = mMuch
            let much = mMuch == "暂时缺票" ? "" : "\((model.minPrice)!)"
            ticketMuch.text = much
        }else{
            ticketmMuch.text = "元起"
            ticketMuch.text = "\((model.minPrice)!)"
        }
        ticketTime.text = model.showDate
        self.setUpTicketStatues(model)
    }
    
    func setUpTicketStatues(_ model:TicketShowModel){
        var statuesArray:[String] = []
        if model.minDiscount != "" && Double(model.minDiscount) < 1 && Double(model.minDiscount) > 0{
            statuesArray.append("\((Double(model.minDiscount)! * 10))折")
        }
        if model.remainCount != 0 && model.remainCount <= 20{
            statuesArray.append("最后\((model.remainCount)!)张")
        }
        if model.ticketStatus == 0 {
            statuesArray.append("预售中")
            self.setUpStatuesView(statuesArray, types: [statuesArray.count])
        }else{
            if statuesArray.count > 0 {
                self.setUpStatuesView(statuesArray, types: nil)
            }else{
                self.setUpStatuesView([], types: nil)
            }
        }
    }
    
    func setUpStatuesView(_ titles:[String], types:NSArray?){
        if ticketStatusView == nil {
            ticketStatusView = GlobalTicketStatus(frame: CGRect.zero, titles: titles, types: types)
            self.contentView.addSubview(ticketStatusView)
            
            ticketStatusView.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.height.equalTo(16)
            })
            self.updateConstraintsIfNeeded()
        }else{
            ticketStatusView.setUpView(titles, types: types)
        }
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketPhoto.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
                make.width.equalTo(82)
            })
            
            ticketTitle.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(13)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })

            ticketTime.snp.makeConstraints({ (make) in
                make.top.equalTo(self.ticketTitle.snp.bottom).offset(6)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.height.equalTo(14)
            })

            ticketLocation.snp.makeConstraints({ (make) in
                make.top.equalTo(self.ticketTime.snp.bottom).offset(1)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.height.equalTo(14)
            })

            ticketmMuch.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-24)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
            })

            ticketMuch.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-11)
                make.right.equalTo(self.ticketmMuch.snp.left).offset(-4)
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
