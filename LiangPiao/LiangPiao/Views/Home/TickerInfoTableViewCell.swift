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
    var ticketStatus:GlobalTicketStatus!
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
        ticketNomalPrice.font = Home_Ticker_NomalPrice_Font
        ticketNomalPrice.textColor = UIColor.init(hexString: Home_Ticker_NomalPrice_Color)
        self.addSubview(ticketNomalPrice)
        
        ticketRow = UILabel()
        ticketRow.text = "502 22排"
        ticketRow.textColor = UIColor.init(hexString: Home_Ticker_Row_Color)
        ticketRow.font = Home_Ticker_Row_Font
        self.contentView.addSubview(ticketRow)
        
        ticketDescirp = UILabel()
        ticketDescirp.text = "连座 现场取票 快递取票"
        ticketDescirp.font = Home_Ticker_Descrip_Font
        ticketDescirp.textColor = UIColor.init(hexString: Home_Ticker_Descrip_Color)
        self.addSubview(ticketDescirp)
        
        ticketNowPrice = UILabel()
        ticketNowPrice.text = "2280"
        ticketNowPrice.font = Home_Ticker_NowPrice_Font
        ticketNowPrice.textColor = UIColor.init(hexString: Home_Ticker_NowPrice_Color)
        self.addSubview(ticketNowPrice)
        
        ticketStatus = GlobalTicketStatus(frame: CGRectZero, titles: ["连","最后五张"], types: nil)
        self.addSubview(ticketStatus)
        
        lineLabel = GloabLineView(frame: CGRectMake(15, 59.5, SCREENWIDTH - 30, 0.5))
        self.addSubview(lineLabel)
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            ticketNomalPrice.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(25)
                make.top.equalTo(self.contentView.snp_top).offset(14)
            })
            
            ticketRow.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_top).offset(14)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            ticketDescirp.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.ticketRow.snp_bottom).offset(7)
                make.centerX.equalTo(self.contentView.snp_centerX).offset(0)
            })
            
            ticketNowPrice.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-25)
                make.top.equalTo(self.contentView.snp_top).offset(14)
            })
            
            ticketStatus.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(self.contentView.snp_right).offset(-(ticketStatus.getMaxWidth() + 25))
                make.top.equalTo(self.ticketNowPrice.snp_bottom).offset(3)
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
