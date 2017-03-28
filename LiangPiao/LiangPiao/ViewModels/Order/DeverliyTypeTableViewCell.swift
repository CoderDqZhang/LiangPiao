//
//  DeverliyTypeTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit
enum DeverliyTypeTableViewCellType {
    case Doing
    case Done
    case None
}

class DeverliyTypeTableViewCell: UITableViewCell {

    var cellType:DeverliyTypeTableViewCellType!
    var leftLine:UILabel!
    var leftLabel:UILabel!
    var infoLabel:UILabel!
    var timeLabel:UILabel!
    
    var phoneStr:String = ""
    
    var didMakeContraints:Bool = false
    
    var linLabel:GloabLineView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
        leftLine = UILabel()
        leftLine.backgroundColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
        self.contentView.addSubview(leftLine)
        
        leftLabel = UILabel()
        leftLabel.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        leftLabel.layer.cornerRadius = 4.5
        leftLabel.layer.borderWidth = 1
        leftLabel.layer.borderColor = UIColor.init(hexString: App_Theme_DDE0E5_Color).CGColor
        self.contentView.addSubview(leftLabel)
        
        
        infoLabel = UILabel()
        infoLabel.font = App_Theme_PinFan_R_13_Font
        infoLabel.numberOfLines = 0
        infoLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        self.contentView.addSubview(infoLabel)
        
        timeLabel = UILabel()
        timeLabel.font = App_Theme_PinFan_R_13_Font
        timeLabel.numberOfLines = 0
        timeLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        self.contentView.addSubview(timeLabel)
        
        linLabel = GloabLineView(frame: CGRectMake(15, 0, SCREENWIDTH - 65, 0.5))
        self.contentView.addSubview(linLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setUpData(trace:Trace, type:DeverliyTypeTableViewCellType) {
        infoLabel.text = trace.acceptStation
        timeLabel.text = trace.acceptTime
        leftLabel.layer.masksToBounds = false
        switch type {
        case .Doing:
            self.leftLabel.hidden = false
            self.leftLine.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView.snp_centerY).offset(0)
                make.left.equalTo(self.contentView.snp_left).offset(27)
                make.width.equalTo(1)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(0)
            })
            leftLabel.layer.masksToBounds = true
            self.leftLabel.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            self.leftLabel.layer.borderColor = UIColor.init(hexString: App_Theme_4BD4C5_Color).CGColor
            infoLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            timeLabel.textColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
            self.linLabel.hidden = false
        case .Done:
            self.leftLabel.hidden = false
            self.leftLabel.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            self.leftLabel.layer.borderColor = UIColor.init(hexString: App_Theme_DDE0E5_Color).CGColor
            infoLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
            timeLabel.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
            self.linLabel.hidden = false
        default:
            self.leftLabel.hidden = true
            self.linLabel.hidden = true
        }
        self.strWithPhoneNumber(trace.acceptStation).subscribeNext { (range) in
            let str = NSMutableAttributedString.init(string: trace.acceptStation)
            str.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: App_Theme_4BD4C5_Color), range: range as! NSRange)
            self.infoLabel.attributedText = str
//            print(range)
            self.phoneStr = trace.acceptStation.substringWithRange((range as! NSRange).location, end: (range as! NSRange).location + (range as! NSRange).length)
            self.infoLabel.userInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(DeverliyTypeTableViewCell.singleTap(_:)))
            singleTap.numberOfTapsRequired = 1
            singleTap.numberOfTouchesRequired = 1
            self.infoLabel.addGestureRecognizer(singleTap)
            
        }
    }
    
    func singleTap(tap:UITapGestureRecognizer) {
        AppCallViewShow(self.contentView, phone: self.phoneStr)
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
            leftLine.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(27)
                make.top.equalTo(self.contentView.snp_top).offset(0)
                make.width.equalTo(1)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(0)
            })
            
            leftLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(23)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 9, height: 9))
            })
            
            infoLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(53.5)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.top.equalTo(self.contentView.snp_top).offset(20)
            })
            
            timeLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(53.5)
                make.top.equalTo(self.infoLabel.snp_bottom).offset(2)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
            })
            
            linLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(53.5)
                make.right.equalTo(self.contentView.snp_right).offset(-15)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-1)
            })
            
            self.didMakeContraints = true
            
        }
        super.updateConstraints()
    }
    
    
    func strWithPhoneNumber(str:String) -> RACSignal{
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            do {
                let regex = try NSRegularExpression.init(pattern: "\\d*", options: NSRegularExpressionOptions.CaseInsensitive)
                regex.enumerateMatchesInString(str, options: NSMatchingOptions.ReportProgress, range: NSRange.init(location: 0, length: str.length), usingBlock: { (result, flags, stop) in
                    if NSTextCheckingType.PhoneNumber == result!.resultType{
                        subscriber.sendNext(result?.range)
                        subscriber.sendCompleted()
                    }
                    if result!.range.length == 11 {
                        subscriber.sendNext(result?.range)
                        subscriber.sendCompleted()
                    }
                })
            } catch  {
            }
            return nil
        })
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
