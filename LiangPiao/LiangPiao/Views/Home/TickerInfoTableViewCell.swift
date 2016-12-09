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
        
        lineLabel = GloabLineView(frame: CGRectMake(15, 59.5, SCREENWIDTH - 30, 0.5))
        self.contentView.addSubview(lineLabel)
        self.updateConstraintsIfNeeded()
    }
    
    
    func setData(model:TicketList) {
        ticketNomalPrice.text = "\(model.originalTicket.name)"
        if model.region == "" {
            ticketRow.text = "择优分配"
        }else{
            let row = model.row != "" ? "\(model.row)排" : ""
            ticketRow.text = "\(model.region) \(row)"
        }
        ticketNowPrice.text = "\(model.price)"
        ticketDescirp.text = self.setUpTickeDelivery(model)
        self.setUpTicketStatues(model)
        
        self.updateConstraintsIfNeeded()
        
    }
    
    func setUpTickeDelivery(model:TicketList) -> String{
        var delivery:String = ""
        let typeArray = model.deliveryType.componentsSeparatedByString(",")
        if model.sellType == 2 {
            delivery = delivery.stringByAppendingString("打包购买 ")
        }
        for str in typeArray {
            if str == "1" {
               delivery = delivery.stringByAppendingString("快递 ")
            }else if str == "3"  {
                delivery = delivery.stringByAppendingString("上门自取")
            }else if str == "2" {
                delivery = delivery.stringByAppendingString("自取")
            }
        }
        return delivery
    }
    
    func setUpTicketStatues(model:TicketList){
        var statuesArray:[String] = []
        if model.seatType == 1{
            statuesArray.append("连")
        }
        if model.remainCount != 0 {
            let str = model.remainCount >= 20 ? "剩余\(model.remainCount)张" : "最后\(model.remainCount)张"
            statuesArray.append(str)
        }
        if statuesArray.count > 0 {
            self.setUpStatuesView(statuesArray, types: nil)
        }else{
            self.setUpStatuesView([], types: nil)
        }
    }
    
    func setUpStatuesView(titles:[String], types:NSArray?){
        if ticketStatusView == nil {
            ticketStatusView = GlobalTicketStatus(frame: CGRectZero, titles: titles, types: types)
            self.contentView.addSubview(ticketStatusView)
            
            ticketStatusView.snp_remakeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-(ticketStatusView.getMaxWidth() + 25))
                make.top.equalTo(self.ticketNowPrice.snp_bottom).offset(3)
            })
        }else{
            ticketStatusView.setUpView(titles, types: types)
            ticketStatusView.snp_remakeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-(ticketStatusView.getMaxWidth() + 25))
                make.top.equalTo(self.ticketNowPrice.snp_bottom).offset(3)
            })
        }
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketNomalPrice.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(25)
                make.top.equalTo(self.contentView.snp_top).offset(15)
            })
            
            ticketRow.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(15)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            ticketDescirp.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.ticketRow.snp_bottom).offset(5)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            ticketNowPrice.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-25)
                make.top.equalTo(self.contentView.snp_top).offset(14)
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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
