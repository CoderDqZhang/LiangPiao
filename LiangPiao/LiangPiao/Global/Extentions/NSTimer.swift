//
//  NSTimer.swift
//  LiangPiao
//
//  Created by Zhang on 12/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation
public typealias TimerExcuteClosure = @convention(block)()->()

extension NSTimer{
    public class func YQ_scheduledTimerWithTimeInterval(ti:NSTimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> NSTimer{
        return self.scheduledTimerWithTimeInterval(ti, target: self, selector: #selector(NSTimer.excuteTimerClosure(_:)), userInfo: unsafeBitCast(closure, AnyObject.self), repeats: true)
    }
    
    class func excuteTimerClosure(timer: NSTimer)
    {
        let closure = unsafeBitCast(timer.userInfo, TimerExcuteClosure.self)
        closure()
    }
}
