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
        
    }
    
    func setUpDate(_ dateString:String){
//        let date = NSDate.init()
//        let zone = NSTimeZone.systemTimeZone()
//        let interval:Double = Double(zone.secondsFromGMTForDate(date))
//        let nowData = date.dateByAddingTimeInterval(interval)
        let startLongLong:Int64 = self.countDownLabel.longLong(from: Date.init()) / 1000 * 1000
        let secondeLongLong = 9 * 60 + 59
        let secontrong = dateString
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let newDate = dateFormatter.date(from: secontrong)
        let finish:Int64 = self.countDownLabel.longLong(from: newDate) / 1000 * 1000
        let finishLongLong =  (secondeLongLong * 1000 + finish)

        self.startLongLongStartStamp(startLongLong, longlongFinishStamp: finishLongLong)
    }
    
    func setUpView() {
        minuteLabel = self.createLabel(CGRect(x: 0, y: 0, width: 13, height: 15), backGroundColor: UIColor.init(hexString: App_Theme_8A96A2_Color), textColor: UIColor.init(hexString: App_Theme_FFFFFF_Color))
        self.addSubview(minuteLabel)
        
        minutesLabel = self.createLabel(CGRect(x: minuteLabel.frame.maxX + 5, y: 0, width: 13, height: 15), backGroundColor: UIColor.init(hexString: App_Theme_8A96A2_Color), textColor: UIColor.init(hexString: App_Theme_FFFFFF_Color))
        self.addSubview(minutesLabel)
        
        timeLabel = self.createLabel(CGRect(x: minutesLabel.frame.maxX + 5, y: -1, width: 2, height: 15), backGroundColor: UIColor.init(hexString: App_Theme_8A96A2_Color), textColor: UIColor.init(hexString: App_Theme_FFFFFF_Color))
        timeLabel.text = ":"
        timeLabel.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
        timeLabel.backgroundColor = UIColor.clear
        self.addSubview(timeLabel)
        
        secondeLabel = self.createLabel(CGRect(x: timeLabel.frame.maxX + 5, y: 0, width: 13, height: 15), backGroundColor: UIColor.init(hexString: App_Theme_8A96A2_Color), textColor: UIColor.init(hexString: App_Theme_FFFFFF_Color))
        self.addSubview(secondeLabel)
        
        secondesLabel = self.createLabel(CGRect(x: secondeLabel.frame.maxX + 5, y: 0, width: 13, height: 15), backGroundColor: UIColor.init(hexString: App_Theme_8A96A2_Color), textColor: UIColor.init(hexString: App_Theme_FFFFFF_Color))
        self.addSubview(secondesLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func createLabel(_ frame:CGRect, backGroundColor:UIColor, textColor:UIColor) -> UILabel {
        let label = UILabel(frame: frame)
        label.backgroundColor = backGroundColor
        label.layer.cornerRadius = 2.0
        label.layer.masksToBounds = true
        label.textColor = textColor
        label.font = App_Theme_PinFan_R_11_Font
        label.textAlignment = .center
        return label
    }
    
    func startLongLongStartStamp(_ strtLL:Int64 , longlongFinishStamp:Int64 ) {
        countDownLabel.countDown(withStratTimeStamp: strtLL, finishTimeStamp: longlongFinishStamp) { (day, hour, minute, second) in
            self.refreshView(day, hour: hour, minute: minute, secondes: second)
        }
    }
    
    func refreshView(_ day:NSInteger, hour:NSInteger, minute:NSInteger, secondes:NSInteger) {
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
        if day == 0 && hour == 0 && minute == 0 && secondes == 0 {
            Notification(OrderStatuesChange, value: "2")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
