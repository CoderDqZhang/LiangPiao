
//
//  UIButton+Extentions.swift
//  LiangPiao
//
//  Created by Zhang on 12/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func buttonSetThemColor(bgColor:String, selectColor:String, size:CGSize) {
        self.setBackgroundImage(UIImage.init(color: UIColor.init(hexString: bgColor), size: size), forState: .Normal)
        self.setBackgroundImage(UIImage.init(color: UIColor.init(hexString: selectColor), size: size), forState: .Highlighted)
    }
    
    func buttonSetTitleColor(nTitleColor:String, sTitleColor:String?) {
        self.setTitleColor(UIColor.init(hexString: nTitleColor), forState: .Normal)
        if sTitleColor == nil {
            self.setTitleColor(UIColor.init(hexString: UIColor.init(hexString: App_Theme_A2ABB5_Color)), forState: .Selected)
        }else{
            self.setTitleColor(UIColor.init(hexString: sTitleColor), forState: .Selected)
        }
    }
}
