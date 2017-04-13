//
//  TicketDescripTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
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


typealias VenueMapClouse = (_ view:UIView) ->Void

class TicketDescripTableViewCell: UITableViewCell {

    var ticketPhoto:UIImageView!
    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLocation:UILabel!
    var ticketStatusView:GlobalTicketStatus!
    var appTicketState:UILabel!
    var lineLabel:GloabLineView!
    var venueMap:UIView!
    var venueTitle:UILabel!
    var seatImageView: UIImageView!
    var venueMapClouse:VenueMapClouse!
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
        
        ticketTime = UILabel()
        ticketTime.text = "2016.10.14 - 2016.11.28"
        ticketTime.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketTime.font = App_Theme_PinFan_R_12_Font
        ticketTime.numberOfLines = 0
        self.contentView.addSubview(ticketTime)
        
        ticketLocation = UILabel()
        ticketLocation.text = "展览馆剧场"
        ticketLocation.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketLocation.font = App_Theme_PinFan_R_12_Font
        self.contentView.addSubview(ticketLocation)
        
        appTicketState = UILabel()
        appTicketState.text = "全部在售门票，100%保真，安全交易，无票赔付"
        appTicketState.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        appTicketState.font = App_Theme_PinFan_R_12_Font!
        appTicketState.numberOfLines = 0
        appTicketState.isUserInteractionEnabled = true
        UILabel.changeLineSpace(for: appTicketState, withSpace: 3.0)
        self.contentView.addSubview(appTicketState)
        
        lineLabel = GloabLineView(frame: CGRect(x: 15, y: 139.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        let image = UIImage.init(named: "Icon_Seat")
        seatImageView = UIImageView.init()
        seatImageView.image = image
        seatImageView.isUserInteractionEnabled = true
        self.contentView.addSubview(seatImageView)
        
        venueTitle = UILabel.init()
        venueTitle.text = "查看座位图"
        venueTitle.isUserInteractionEnabled = true
        venueTitle.font = App_Theme_PinFan_R_12_Font
        venueTitle.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.contentView.addSubview(venueTitle)
        
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(TicketDescripTableViewCell.venueMapTap(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        
        venueTitle.addGestureRecognizer(singleTap)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setHiddenLine(_ hidden:Bool){
        lineLabel.isHidden = hidden
    }
    
    func venueMapTap(_ tap:UITapGestureRecognizer){
        print(self.venueTitle.frame)
        if self.venueMapClouse != nil {
            self.venueMapClouse(self.venueTitle)
        }
    }
    
    func setData(_ model:TicketShowModel, sessionModel:ShowSessionModel){
        ticketPhoto.sd_setImage(with: URL.init(string: model.cover), placeholderImage: UIImage.init(named: "Feeds_Default_Cover"), options: .retryFailed, progress: { (start, end, url) in
            
        }) { (image, error, cacheType, url) in
            _ = SaveImageTools.sharedInstance.saveImage("\(model.id).png", image: image!, path: "TicketShowImages")
        }
        
        ticketTitle.text = model.title
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        if model.sessionCount != nil {
            ticketTime.text = "\((sessionModel.startTime)!)"
        }else{
            ticketTime.text = "\((sessionModel.name)!)"
        }
        ticketLocation.text = model.venue.name

        if sessionModel.venueMap != "" {
            seatImageView.isHidden = false
            venueTitle.isHidden = false
        }else{
            seatImageView.isHidden = true
            venueTitle.isHidden = true

        }
        
        self.setUpTicketStatues(sessionModel)
        
        
    }
    
    func setUpVenueMap(){
        
    }
    
    func setUpTicketStatues(_ model:ShowSessionModel){
        var statuesArray:[String] = []
        if model.minDiscount != "" && model.minDiscount != "0.0" && Double(model.minDiscount) < 1{
            statuesArray.append("\(Double(model.minDiscount)! * 10)折")
        }
        if model.ticketCount != 0 {
            let str = model.ticketCount >= 20 ? "剩余\((model.ticketCount)!)张" : "最后\((model.ticketCount)!)张"
            statuesArray.append(str)
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
                make.bottom.equalTo(self.appTicketState.snp.top).offset(-7)
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
            
            ticketTime.snp.makeConstraints({ (make) in
                make.top.equalTo(self.ticketTitle.snp.bottom).offset(6)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            ticketLocation.snp.makeConstraints({ (make) in
                make.top.equalTo(self.ticketTime.snp.bottom).offset(1)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(12)
            })
            
            seatImageView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.ticketTime.snp.bottom).offset(3)
                make.left.equalTo(self.ticketLocation.snp.right).offset(14)
            })
            
            venueTitle.snp.makeConstraints({ (make) in
                make.top.equalTo(self.ticketTime.snp.bottom).offset(1)
                make.left.equalTo(self.ticketLocation.snp.right).offset(34)
//                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            appTicketState.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-17)
                make.left.equalTo(self.ticketPhoto.snp.right).offset(11)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
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
