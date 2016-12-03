//
//  OrderFormModel.swift
//  LiangPiao
//
//  Created by Zhang on 29/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum FormDelivityType {
    case expressage
    case presentRecive
    case visitRecive
}

enum PayType {
    case weiChat
    case aliPay
}

class OrderFormModel: NSObject {
    var ticketID : Int?
    var ticketCount : Int?
    var deliveryType : FormDelivityType?
    var message : String? = ""
    var deliveryPrice : String?
    var payType : PayType = .weiChat
    var phone : String?
    var name : String?
    var addressId : Int?
    
    private override init() {
        print("")
    }
    
    static let shareInstance = OrderFormModel()
}
