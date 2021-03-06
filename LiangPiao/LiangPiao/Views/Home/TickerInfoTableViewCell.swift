//
//  TickerInfoTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TickerInfoTableViewCell: UITableViewCell {

    var ticketNomalPrice:UILabel!
    var ticketRow:UILabel!
    var ticketDescirp:UILabel!
    var ticketNowPrice:UILabel!
    var ticketNowPriceInfo:UILabel!
    var ticketStatusView:GlobalTicketStatus!
    var lineLabel:GloabLineView!
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        ticketNomalPrice = UILabel()
        ticketNomalPrice.text = "880"
        ticketNomalPrice.font = App_Theme_PinFan_R_13_Font
        ticketNomalPrice.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        self.contentView.addSubview(ticketNomalPrice)
        
        ticketRow = UILabel()
        ticketRow.text = "502 22排"
        ticketRow.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        ticketRow.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(ticketRow)
        
        ticketDescirp = UILabel()
        ticketDescirp.text = "连座 现场取票 快递取票"
        ticketDescirp.font = App_Theme_PinFan_R_10_Font
        ticketDescirp.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        self.contentView.addSubview(ticketDescirp)
        
        ticketNowPrice = UILabel()
        ticketNowPrice.text = "2280"
        ticketNowPrice.font = App_Theme_PinFan_R_14_Font
        ticketNowPrice.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.contentView.addSubview(ticketNowPrice)
        
        ticketNowPriceInfo = UILabel()
        ticketNowPriceInfo.text = "元"
        ticketNowPriceInfo.font = App_Theme_PinFan_R_13_Font
        ticketNowPriceInfo.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.contentView.addSubview(ticketNowPriceInfo)
        
        lineLabel = GloabLineView(frame: CGRect(x: 15, y: 59.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        self.updateConstraintsIfNeeded()
    }
    
    
    func setData(_ model:TicketList) {
        ticketNomalPrice.text = "\((model.originalTicket.name)!)"
        if model.region == "" {
            ticketRow.text = "随机"
        }else{
            let row = model.row != "" ? "\((model.row)!)排" : "随机"
            ticketRow.text = "\((model.region)!) \(row)"
        }
        ticketNowPrice.text = "\((model.price)!)"
        ticketDescirp.text = self.setUpTickeDelivery(model)
        self.setUpTicketStatues(model)
    }
    
    func setUpTickeDelivery(_ model:TicketList) -> String{
        var delivery:String = ""
        let typeArray = model.deliveryType.components(separatedBy: ",")
        if model.sellType == 2 {
            delivery = delivery + "打包购买 "
        }
        var express = false
        for str in typeArray {
            if (str == "1" || str == "4") && !express {
               delivery = delivery + "快递 "
                express = true
            }else if str == "3"  {
                delivery = delivery + "上门自取 "
            }else if str == "2" {
                delivery = delivery + "自取 "
            }
        }
        if model.seatType == 1{
            delivery = delivery + "连坐"
        }
        return delivery
    }
    
    func setUpTicketStatues(_ model:TicketList){
        var statuesArray:[String] = []
        let array = NSMutableArray()
        if model.sellCategory != nil && model.sellCategory == 1 {
            statuesArray.append("期票")
            array.add(1)
        }
        if model.remainCount != 0 {
            let str = model.remainCount >= 20 ? "剩余\((model.remainCount)!)张" : "最后\((model.remainCount)!)张"
            statuesArray.append(str)
            array.add(0)
        }
        if statuesArray.count > 0 {
            self.setUpStatuesView(statuesArray, types: array)
        }else{
            self.setUpStatuesView([], types: nil)
        }
    }
    
    func setUpStatuesView(_ titles:[String], types:NSArray?){
        if ticketStatusView == nil {
            ticketStatusView = GlobalTicketStatus(frame: CGRect.zero, titles: titles, types: types)
            self.contentView.addSubview(ticketStatusView)
            
            ticketStatusView.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-(ticketStatusView.getMaxWidth() + 25))
                make.top.equalTo(self.ticketNowPrice.snp.bottom).offset(3)
            })
        }else{
            ticketStatusView.setUpView(titles, types: types)
            ticketStatusView.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-(ticketStatusView.getMaxWidth() + 25))
                make.top.equalTo(self.ticketNowPrice.snp.bottom).offset(3)
            })
        }
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketNomalPrice.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(25)
                make.top.equalTo(self.contentView.snp.top).offset(15)
            })
            
            ticketRow.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
            })
            
            ticketDescirp.snp.makeConstraints({ (make) in
                make.top.equalTo(self.ticketRow.snp.bottom).offset(5)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
            })
            
            ticketNowPrice.snp.makeConstraints({ (make) in
                make.right.equalTo(self.ticketNowPriceInfo.snp.left).offset(-2)
                make.top.equalTo(self.contentView.snp.top).offset(14)
            })
            
            ticketNowPriceInfo.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-25)
                make.top.equalTo(self.contentView.snp.top).offset(14.5)
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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
