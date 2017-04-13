
//
//  SpalshView.swift
//  LiangPiao
//
//  Created by Zhang on 22/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SpalshView: UIView {

    var logoView:UIView!
    var projectionView:UIView!
    var logoImageView:UIImageView!
    var projectionImageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        let image = UIImage.init(named: "splash_logo")
        let splash_shadow = UIImage.init(named: "splash_shadow")
        
        projectionView = UIView()
        projectionImageView = UIImageView()
        projectionImageView.image = UIImage.init(named: "splash_shadow")
        projectionView.addSubview(projectionImageView)
//        projectionView.layer.addAnimation(self.projectionAnimation(), forKey: nil)
        projectionView.layer.add(self.projectionAnimations(), forKey: nil)
        
        projectionView.isHidden = true
        self.addSubview(self.projectionView)

        
        projectionView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: (splash_shadow?.size.width)! * 2, height: (splash_shadow?.size.height)!))
            make.centerX.equalTo(self.snp.centerX).offset(45)
            make.centerY.equalTo(self.snp.centerY).offset(-76)
        }
        
        projectionImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: (splash_shadow?.size.width)!, height: (splash_shadow?.size.height)!))
            make.top.equalTo(projectionView.snp.top).offset(0)
            make.left.equalTo(projectionView.snp.left).offset(0)
        }
        
        logoView = UIView()
//        logoView.backgroundColor = UIColor.grayColor()
        logoView.layer.add(self.logAnimation(), forKey: nil)
        logoView.layer.add(self.logAnimations(), forKey: nil)
        self.addSubview(logoView)
        
        logoImageView = UIImageView()
        logoImageView.image = image
        logoView.addSubview(logoImageView)

        self.bringSubview(toFront: logoView)
        
        logoView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: (image?.size.width)! * 2, height: (image?.size.height)!))
            make.centerX.equalTo(self.snp.centerX).offset(-((image?.size.width)!)/2 + 10)
            make.centerY.equalTo(self.snp.centerY).offset(-80)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: (image?.size.width)!, height: (image?.size.height)!))
            make.top.equalTo(logoView.snp.top).offset(0)
            make.right.equalTo(logoView.snp.right).offset(0)
        }
        
        
        
        _ = Timer.YQ_scheduledTimerWithTimeInterval(1.65, closure: {
//            self.bringSubviewToFront(self.logoView)
//            self.projectionView.hidden = false
            }, repeats: false)
        
        self.updateConstraintsIfNeeded()
    }

    func logAnimation() -> CAKeyframeAnimation{
        //LOGO轴动画效果：
        let ani = CAKeyframeAnimation(keyPath: "transform.rotation.y")
        ani.keyTimes = [0,1]
        ani.timingFunctions = [CAMediaTimingFunction(controlPoints: 0.017,0.995,0.817,0.998)]
        ani.values = [1.414,0]
        ani.duration = 1.56
        return ani
    }
    
    func logAnimations() -> CAKeyframeAnimation {
        //LOGO透明度动画效果：
        let ani = CAKeyframeAnimation(keyPath: "opacity")
        ani.keyTimes = [0,1]
        ani.timingFunctions = [CAMediaTimingFunction(controlPoints: 0.013,1.007,0.913,0.999)]
        ani.values = [0,1]
        ani.duration = 1.56
        return ani
    }
    
    func projectionAnimation() -> CAKeyframeAnimation{
        //投影轴动画效果：
        let ani = CAKeyframeAnimation(keyPath: "transform.rotation.y")
        ani.keyTimes = [0,1]
        ani.timingFunctions = [CAMediaTimingFunction(controlPoints: 0.006,1.003,0.867,0.997)]
        ani.values = [-1.222,-0.157]
        ani.duration = 1.56
        return ani
    }
    
    func projectionAnimations() -> CAKeyframeAnimation{
        //投影透明度动画效果：
        let ani = CAKeyframeAnimation(keyPath: "opacity")
        ani.keyTimes = [0,1]
        ani.timingFunctions = [CAMediaTimingFunction(controlPoints: 0.04,0.598,0.86,1)]
        ani.values = [0,0.7]
        ani.duration = 1.56
        return ani
    }
}
