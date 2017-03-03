//
//  LiangPiaoHomeRefreshHeader.swift
//  LiangPiao
//
//  Created by Zhang on 12/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class LiangPiaoHomeRefreshHeader: UIView {

    var imageView:UIImageView!
    var loadImageView:UIImageView!
    var displayLink:CADisplayLink!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.displayLink.invalidate()
    }
    
    func setUpView(){
        self.backgroundColor = UIColor.clearColor()
        imageView = UIImageView()
        self.imageView.frame = CGRect.init(x: self.center.x - 14, y: 49, width: 28, height: 28)
        self.addSubview(imageView)

        loadImageView = UIImageView()
        loadImageView.image = UIImage.init(named: "加载动画圆点")
        self.loadImageView.frame = CGRect.init(x: self.center.x - 14, y: 49, width: 28, height: 28)
        self.addSubview(loadImageView)
        
        self.displayLink = CADisplayLink.init(target: self, selector: #selector(LiangNomalRefreshHeader.startAnimation))
        self.displayLink.frameInterval = 60
        self.displayLink.paused = false
        self.displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)

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
        self.loadImageView.layer.removeAllAnimations()
        self.displayLink.paused = true
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
