//
//  LiangPiaoLoadMoreDataFooter.swift
//  LiangPiao
//
//  Created by Zhang on 12/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import MJRefresh

class LiangPiaoLoadMoreDataFooter: MJRefreshBackFooter {

    var imageView:UIImageView!
    var loadImageView:UIImageView!
    var oldState:MJRefreshState!
    var timer = NSTimer()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func prepare() {
        super.prepare()
        self.backgroundColor = UIColor.whiteColor()
        self.mj_h = 88
        let imageView = UIImageView()
        self.addSubview(imageView)
        
        self.imageView = imageView
        
        let loadImageView = UIImageView()
        self.addSubview(loadImageView)
        imageView.image = UIImage.init(named: "加载动画圆点")
        self.loadImageView = loadImageView
    }
    
    func prepareImage(backImage:UIImage, loadImage:UIImage) {
        self.prepare()
        imageView.image = backImage
        loadImageView.image = loadImage
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        self.imageView.frame = CGRect.init(x: self.center.x - 14, y: 30, width: 28, height: 28)
        self.loadImageView.frame = CGRect.init(x: self.center.x - 14, y: 30, width: 28, height: 28)
        loadImageView.image = UIImage.init(named: "加载动画圆点")
        imageView.image = UIImage.init(named: "加载动画背景")
    }
    
    override func scrollViewPanStateDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewContentOffsetDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func setState(state:MJRefreshState) {
        
        if state == oldState {
            return
        }
        oldState = self.state

        super.setState(state)
        switch state {
        case .Idle:
            self.stopAnimation()
            break
        case .Pulling:
            timer = NSTimer.YQ_scheduledTimerWithTimeInterval(1, closure: {
                self.startAnimation()
                }, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
            break
        case .Refreshing:
            self.startAnimation()
            break
        case .NoMoreData:
            self.stopAnimation()
            break
        default:
            break
        }
    }
    
    func startAnimation() {
        let ani = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        ani.keyTimes = [0,0.48,1]
        ani.timingFunctions = [CAMediaTimingFunction(controlPoints: 0.014,-0.003,0.726,0.306), CAMediaTimingFunction(controlPoints: 0.233,0.824,0.326,0.97)]
        ani.values = [0,3.543,6.283]
        ani.duration = 1
        
        self.loadImageView.layer.addAnimation(ani, forKey: nil)
    }
    
    func stopAnimation(){
        timer.timeInterval
        self.loadImageView.layer.removeAllAnimations()
    }
    
}
