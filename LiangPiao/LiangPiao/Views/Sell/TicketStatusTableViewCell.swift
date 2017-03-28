
//
//  TicketStatusTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/16.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

typealias TicketStatusTableViewCellClouse = (isSeate:Bool, isTicket:Bool) ->Void
typealias TicketTicketSellClouse = (tap:UITapGestureRecognizer, label:UILabel) ->Void
class TicketStatusTableViewCell: UITableViewCell {

    var ticketStatus:UIView!
    var isSeat:Bool = false
    var isTicket:Bool = false
    var ticketTicketSellClouse:TicketTicketSellClouse!
    var ticketStatusTableViewCellClouse:TicketStatusTableViewCellClouse!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setTicketModel(model:SellFormModel){
        var array:[String]! = []
        var typeArray:[NSInteger]! = []
        if model.seatType == "1" {
            if model.number > 1 {
                array.append("保证连坐")
                array.append("期票预售")
                typeArray.append(1)
            }else{
                array.append("期票预售")
            }
        }else{
            if model.number > 1 {
                array.append("保证连坐")
                array.append("期票预售")
                typeArray.append(0)
            }else{
                array.append("期票预售")
            }
        }
        if model.sellCategoty == 1 {
            typeArray.append(1)
        }else{
            typeArray.append(0)
        }
        ticketStatus = UIView.init(frame: CGRect.init(x: 15, y: 17, width: SCREENWIDTH - 30, height: 35))
        self.setUpLable(array, type: typeArray)
        self.contentView.addSubview(ticketStatus)

    }
    
    func setUpLable(titles:[String], type:[NSInteger]){
        for index in 0...titles.count - 1 {
            let seatLabel = self.setUpLabel(CGRect.init(x: index * (66 + 10), y: 0, width: 66, height: 35), title: titles[index], tag: index, type: type[index])
            self.ticketStatus.addSubview(seatLabel)
        }
    }
    
    func setUpLabel(frame:CGRect, title:String, tag:NSInteger,type:NSInteger) -> UILabel{
        let label = UILabel.init(frame: frame)
        label.text = title
        label.font = App_Theme_PinFan_R_12_Font
        label.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        label.layer.borderColor = UIColor.init(hexString: App_Theme_8A96A2_Color).CGColor
        label.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        label.layer.borderWidth = 0.5
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        label.textAlignment = .Center
        label.userInteractionEnabled = true
        if type == 1 {
            label.layer.cornerRadius = 2
            label.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
            label.textColor = UIColor.whiteColor()
            if title == "保证连坐" {
                isSeat = true
            }else{
                isTicket = true
            }
        }
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(TicketStatusTableViewCell.singleTapGesture(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        label.addGestureRecognizer(singleTap)
        return label
    }
    
    func singleTapGesture(tap:UITapGestureRecognizer){
        let label = tap.view as! UILabel
        if label.text == "期票预售" && label.backgroundColor == UIColor.init(hexString: App_Theme_FFFFFF_Color) {
            if self.ticketTicketSellClouse != nil {
                self.ticketTicketSellClouse(tap:tap, label: label)
                return
            }
        }
        self.updataLabel(label)
    }
    
    func updataLabel(label:UILabel){
        if label.backgroundColor == UIColor.init(hexString: App_Theme_FFFFFF_Color) {
            label.layer.cornerRadius = 2
            label.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
            label.textColor = UIColor.whiteColor()
            if label.text == "保证连坐" {
                isSeat = true
            }else{
                isTicket = true
            }
        }else{
            label.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            label.layer.cornerRadius = 2
            label.layer.borderColor = UIColor.init(hexString: App_Theme_8A96A2_Color).CGColor
            label.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
            if label.text == "保证连坐" {
                isSeat = false
            }else{
                isTicket = false
            }
        }
        if (self.ticketStatusTableViewCellClouse != nil) {
            self.ticketStatusTableViewCellClouse(isSeate: isSeat,isTicket: isTicket)
        }
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
