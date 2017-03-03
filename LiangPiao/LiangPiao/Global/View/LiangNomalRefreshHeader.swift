//
//  LiangNomalRefreshHeader.swift
//  LiangPiao
//
//  Created by Zhang on 12/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import MJRefresh

class LiangNomalRefreshHeader: MJRefreshHeader {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var imageView:UIImageView!
    var loadImageView:UIImageView!
    var oldState:MJRefreshState!
    var displayLink:CADisplayLink!
    
    override func prepare() {
        super.prepare()
        self.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.mj_h = 88
        let imageView = UIImageView()
        self.addSubview(imageView)

        self.imageView = imageView

        let loadImageView = UIImageView()
        self.addSubview(loadImageView)
//        imageView.image = UIImage.init(named: "加载动画圆点")
        self.loadImageView = loadImageView
        self.displayLink = CADisplayLink.init(target: self, selector: #selector(LiangNomalRefreshHeader.startAnimation))
        self.displayLink.frameInterval = 60
        self.displayLink.paused = true
        self.displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }

    deinit {
        self.displayLink.invalidate()
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
        loadImageView.image = UIImage.init(named: "刷新动画圆点")
//        imageView.image = UIImage.init(named: "加载动画背景")
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
            self.displayLink.paused = true
            break
        case .Pulling:
            self.displayLink.paused = false
            break
        case .Refreshing:
            self.displayLink.paused = false
            break
        case .NoMoreData:
            self.displayLink.paused = true
            break
        default:
            break
        }
    }

    func startAnimation() {
        if self.loadImageView.layer.animationForKey("done") == nil {
            let ani = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            ani.keyTimes = [0,0.48,1]
            ani.timingFunctions = [CAMediaTimingFunction(controlPoints: 0.014,-0.003,0.726,0.306), CAMediaTimingFunction(controlPoints: 0.233,0.824,0.326,0.97)]
            ani.values = [0,3.543,6.283]
            ani.duration = 1
            self.loadImageView.layer.addAnimation(ani, forKey: "done")
        }
    }
    
    func stopAnimation(){
        self.loadImageView.layer.removeAllAnimations()
        self.displayLink.paused = true
    }
}
