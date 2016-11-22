//
//  ZDQFMDBModel.swift
//  LiangPiao
//
//  Created by Zhang on 15/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class ZDQFMDBModel: NSObject {
    
    
    func getAllPropertys()->[String]{
        
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.alloc(0)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        
        for i in 0 ..< countInt {
            let temp = buff[i]
            let tempPro = property_getName(temp)
            let proper = String.init(UTF8String: tempPro)
            result.append(proper!)
            
        }
        
        return result
    }
}
