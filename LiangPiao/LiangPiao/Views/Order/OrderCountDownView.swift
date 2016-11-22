//
//  CountDownView.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderCountDownView: UIView {

    var minuteLabel:UILabel!
    var minutesLabel:UILabel!
    var timeLabel:UILabel!
    var secondeLabel:UILabel!
    var secondesLabel:UILabel!
    let countDownLabel = CountDown()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        ///方法一倒计时测试
//        let startLongLong:NSInteger = 1467713971000
//        let finishLongLong:NSInteger = 1467714322000
        
        let startLongLong:Int64 = self.countDownLabel.longLongFromDate(NSDate.init()) / 1000 * 1000
        let secondeLongLong = 15 * 60 + 59
        let finishLongLong:Int64  = startLongLong + secondeLongLong * 1000
        self.startLongLongStartStamp(startLongLong, longlongFinishStamp: finishLongLong)
    }
    
    func setUpView() {
        minuteLabel = self.createLabel(CGRectMake(0, 0, 13, 15), backGroundColor: UIColor.init(hexString: Count_Done_BackGround_Color), textColor: UIColor.init(hexString: Count_Done_Text_Color))
        self.addSubview(minuteLabel)
        
        minutesLabel = self.createLabel(CGRectMake(CGRectGetMaxX(minuteLabel.frame) + 5, 0, 13, 15), backGroundColor: UIColor.init(hexString: Count_Done_BackGround_Color), textColor: UIColor.init(hexString: Count_Done_Text_Color))
        self.addSubview(minutesLabel)
        
        timeLabel = self.createLabel(CGRectMake(CGRectGetMaxX(minutesLabel.frame) + 5, -1, 2, 15), backGroundColor: UIColor.init(hexString: Count_Done_BackGround_Color), textColor: UIColor.init(hexString: Count_Done_Text_Color))
        timeLabel.text = ":"
        timeLabel.textColor = UIColor.init(hexString: Count_Done_BackGround_Color)
        timeLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(timeLabel)
        
        secondeLabel = self.createLabel(CGRectMake(CGRectGetMaxX(timeLabel.frame) + 5, 0, 13, 15), backGroundColor: UIColor.init(hexString: Count_Done_BackGround_Color), textColor: UIColor.init(hexString: Count_Done_Text_Color))
        self.addSubview(secondeLabel)
        
        secondesLabel = self.createLabel(CGRectMake(CGRectGetMaxX(secondeLabel.frame) + 5, 0, 13, 15), backGroundColor: UIColor.init(hexString: Count_Done_BackGround_Color), textColor: UIColor.init(hexString: Count_Done_Text_Color))
        self.addSubview(secondesLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func createLabel(frame:CGRect, backGroundColor:UIColor, textColor:UIColor) -> UILabel {
        let label = UILabel(frame: frame)
        label.backgroundColor = backGroundColor
        label.layer.cornerRadius = 2.0
        label.layer.masksToBounds = true
        label.textColor = textColor
        label.font = Count_Done_Text_Font
        label.textAlignment = .Center
        return label
    }
    
    func startLongLongStartStamp(strtLL:Int64 , longlongFinishStamp:Int64 ) {
        countDownLabel.countDownWithStratTimeStamp(strtLL, finishTimeStamp: longlongFinishStamp) { (day, hour, minute, second) in
            self.refreshView(day, hour: hour, minute: minute, secondes: second)
        }
    }
    
    func refreshView(day:NSInteger, hour:NSInteger, minute:NSInteger, secondes:NSInteger) {
        if minute > 10 {
            minuteLabel.text = "\(minute/10)"
            minutesLabel.text = "\(minute%10)"
        }else{
            minuteLabel.text = "0"
            minutesLabel.text = "\(minute)"
        }
        
        if secondes > 10 {
            secondeLabel.text = "\(secondes/10)"
            secondesLabel.text = "\(secondes%10)"
        }else{
            secondeLabel.text = "0"
            secondesLabel.text = "\(secondes)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
