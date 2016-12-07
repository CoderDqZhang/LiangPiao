//
//  PicketUpSessionTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum TicketSessionType {
    case sessionEnable
    case sessionDisble
    case sessionSelect
}

typealias TicketSessionClouse = (tag:NSInteger) -> Void

class TicketSession: UIView {
    var label = UILabel()
    var singTapPress:UITapGestureRecognizer!
    var clouse:TicketSessionClouse?
    var type:NSInteger = 0
    init(frame:CGRect, title:String, tag:NSInteger, clouse:TicketSessionClouse?, type:NSInteger) {
        super.init(frame: frame)
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 2.0
        self.clouse = clouse!
        if type != 0 {
            singTapPress = UITapGestureRecognizer(target: self, action: #selector(TicketSession.singTapPress(_:)))
            singTapPress.numberOfTapsRequired = 1
            singTapPress.numberOfTouchesRequired = 1
            self.addGestureRecognizer(singTapPress)
        }
        self.type = type
        label.text = title
        self.tag = tag
        label.font = App_Theme_PinFan_R_12_Font
        label.numberOfLines = 0
        label.frame = CGRect.init(x: 8, y: 0, width: frame.size.width - 16, height: frame.size.height)
        label.textAlignment = .Left
        self.addSubview(label)
        
        self.upDataType(type)
    }
    
    func upDataType(type:NSInteger){
        switch type {
        case 1:
            let color = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.textColor = UIColor.whiteColor()
            self.backgroundColor = color
            self.layer.borderColor = color.CGColor
        case 2:
            let color = UIColor.init(hexString: App_Theme_556169_Color)
            label.textColor = color
            self.backgroundColor = UIColor.whiteColor()
            self.layer.borderColor = color.CGColor
        default:
            let color = UIColor.init(hexString: App_Theme_DDE0E5_Color)
            label.textColor = color
            self.backgroundColor = UIColor.whiteColor()
            self.layer.borderColor = color.CGColor
        }
    }
    
    func singTapPress(sender:UITapGestureRecognizer) {
        if self.clouse != nil {
            self.clouse!(tag: (sender.view?.tag)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let SESSIONWIDTH:CGFloat = 139
let SESSIONHEIGHT:CGFloat = 50

class PicketUpSessionTableViewCell: UITableViewCell {

    var scrollerView:UIScrollView!
    let sessionTitle = ["2016.12.22 14:00 星期六 上本 0张在售", "2016.12.22 14:00 星期六 上本 0张在售", "2016.12.22 14:00 星期六 上本 0张在售"]
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        scrollerView = UIScrollView.init(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 90))
        
        let sessionTitleStyle = [0, 2, 1]
        var OriginX:CGFloat = 0
        for index in 0...sessionTitle.count - 1 {
            let sessionView = TicketSession.init(frame: CGRect.init(x: OriginX, y: 20, width: SESSIONWIDTH, height: SESSIONHEIGHT), title: sessionTitle[index], tag: index + 10, clouse: { (tag) in
                    self.updateSession(tag)
                }, type: sessionTitleStyle[index])
            OriginX = CGRectGetMaxX(sessionView.frame) + 10
            scrollerView.addSubview(sessionView)
        }
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.contentSize = CGSizeMake(OriginX, 90)
        self.contentView.addSubview(scrollerView)
        
    }
    
    func updateSession(tag:Int){
        for index in 0...sessionTitle.count - 1 {
            let sesstion = scrollerView.viewWithTag(index + 10) as! TicketSession
            if index + 10 == tag {
                sesstion.upDataType(1)
            }else{
                if sesstion.type != 0 {
                    sesstion.upDataType(2)
                }
            }
        }
        self.updateConstraintsIfNeeded()
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
