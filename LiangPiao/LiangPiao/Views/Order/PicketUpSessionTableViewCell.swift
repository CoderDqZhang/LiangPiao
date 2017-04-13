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

typealias TicketSessionClouse = (_ tag:NSInteger) -> Void

class TicketSession: UIView {
    var label = UILabel()
    var singTapPress:UITapGestureRecognizer!
    var clouse:TicketSessionClouse?
    var type:NSInteger = 0
    init(frame:CGRect, title:String, tag:NSInteger, clouse:TicketSessionClouse?, type:NSInteger) {
        super.init(frame: frame)
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 2.0
        self.clouse = clouse!
        singTapPress = UITapGestureRecognizer(target: self, action: #selector(TicketSession.singTapPress(_:)))
        singTapPress.numberOfTapsRequired = 1
        singTapPress.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singTapPress)
        self.type = type
        label.text = title
        self.tag = tag
        label.font = App_Theme_PinFan_R_12_Font
        label.numberOfLines = 0
        label.frame = CGRect.init(x: 8, y: 0, width: frame.size.width - 16, height: frame.size.height)
        label.textAlignment = .left
        self.addSubview(label)
        
        self.upDataType(type)
    }
    
    func upDataType(_ type:NSInteger){
        switch type {
        case 1:
            let color = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            label.textColor = UIColor.white
            self.backgroundColor = color
            self.layer.borderColor = color?.cgColor
        case 2:
            let color = UIColor.init(hexString: App_Theme_556169_Color)
            label.textColor = color
            self.backgroundColor = UIColor.white
            self.layer.borderColor = color?.cgColor
        default:
            let color = UIColor.init(hexString: App_Theme_DDE0E5_Color)
            label.textColor = color
            self.backgroundColor = UIColor.white
            self.layer.borderColor = color?.cgColor
        }
    }
    
    func singTapPress(_ sender:UITapGestureRecognizer) {
        if self.clouse != nil {
            self.clouse!((sender.view?.tag)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let SESSIONWIDTH:CGFloat = 139
let SESSIONHEIGHT:CGFloat = 50

typealias PicketUpSessionClouse = (_ tag:NSInteger) -> Void

class PicketUpSessionTableViewCell: UITableViewCell {

    var scrollerView:UIScrollView!
    var sessionTitle:NSArray!
    var picketUpSessionClouse:PicketUpSessionClouse!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func updateSession(_ tag:Int){
        for index in 0...sessionTitle.count - 1 {
            let sesstionTag = scrollerView.viewWithTag(tag) as! TicketSession
            if sesstionTag.type != 0 {
                let sesstion = scrollerView.viewWithTag(index + 10) as! TicketSession
                if sesstion.type != 0 {
                    if index + 10 == tag {
                        sesstion.upDataType(1)
                    }else{
                        if sesstion.type != 0 {
                            sesstion.upDataType(2)
                        }
                    }
                }
            }
        }
        self.updateConstraintsIfNeeded()
    }
    
    func setUpDataAarray(_ title:NSArray, selectArray:NSArray) {
        if scrollerView == nil {
            sessionTitle = title
            scrollerView = UIScrollView.init(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 90))
            var OriginX:CGFloat = 0
            for index in 0...sessionTitle.count - 1 {
                let sessionView = TicketSession.init(frame: CGRect.init(x: OriginX, y: 20, width: SESSIONWIDTH, height: SESSIONHEIGHT), title: sessionTitle[index] as! String, tag: index + 10, clouse: { (tag) in
                    self.updateSession(tag)
                    if self.picketUpSessionClouse != nil {
                        self.picketUpSessionClouse(tag - 10)
                    }
                    }, type: selectArray.object(at: index) as! Int)
                OriginX = sessionView.frame.maxX + 10
                scrollerView.addSubview(sessionView)
                if Int(selectArray[index] as! NSNumber) == 1 {
                    sessionView.upDataType(1)
                }
            }
            scrollerView.showsHorizontalScrollIndicator = false
            scrollerView.contentSize = CGSize(width: OriginX, height: 90)
            self.contentView.addSubview(scrollerView)
        }
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
