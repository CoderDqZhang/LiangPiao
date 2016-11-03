//
//  String+Size.swift
//  Meet
//
//  Created by Zhang on 6/16/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    //MARK:获得string内容高度
     var length: Int { return self.characters.count }
    
    func heightWithConstrainedWidth(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        let normalText: NSString = textStr
        let size = CGSizeMake(width,1000)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName)
        let stringSize = normalText.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.height
    }
    
    func widthWithConstrainedHeight(textStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        let normalText: NSString = textStr
        let size = CGSizeMake(1000, height)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName)
        let stringSize = normalText.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.width
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
}//extension end

