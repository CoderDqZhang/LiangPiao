//
//  OrderModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
class Wxpay : NSObject, NSCoding{
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        
    }
    
}

class PayUrl : NSObject, NSCoding{
    
    var alipay : String!
    var wxpay : Wxpay!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        alipay = dictionary["alipay"] as? String
        if let wxpayData = dictionary["wxpay"] as? NSDictionary{
            wxpay = Wxpay(fromDictionary: wxpayData)
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if alipay != nil{
            dictionary["alipay"] = alipay
        }
        if wxpay != nil{
            dictionary["wxpay"] = wxpay.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        alipay = aDecoder.decodeObjectForKey("alipay") as? String
        wxpay = aDecoder.decodeObjectForKey("wxpay") as? Wxpay
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if alipay != nil{
            aCoder.encodeObject(alipay, forKey: "alipay")
        }
        if wxpay != nil{
            aCoder.encodeObject(wxpay, forKey: "wxpay")
        }
        
    }
    
}

class OrderModel : NSObject, NSCoding{
    
    var created : String!
    var deliveryPrice : Int!
    var deliveryType : Int!
    var id : Int!
    var message : String!
    var name : String!
    var orderId : String!
    var payDate : String!
    var payType : Int!
    var payUrl : PayUrl!
    var phone : String!
    var price : Int!
    var reason : String!
    var status : Int!
    var statusDesc : String!
    var ticketCount : Int!
    var total : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        created = dictionary["created"] as? String
        deliveryPrice = dictionary["delivery_price"] as? Int
        deliveryType = dictionary["delivery_type"] as? Int
        id = dictionary["id"] as? Int
        message = dictionary["message"] as? String
        name = dictionary["name"] as? String
        orderId = dictionary["order_id"] as? String
        payDate = dictionary["pay_date"] as? String
        payType = dictionary["pay_type"] as? Int
        if let payUrlData = dictionary["pay_url"] as? NSDictionary{
            payUrl = PayUrl(fromDictionary: payUrlData)
        }
        phone = dictionary["phone"] as? String
        price = dictionary["price"] as? Int
        reason = dictionary["reason"] as? String
        status = dictionary["status"] as? Int
        statusDesc = dictionary["status_desc"] as? String
        ticketCount = dictionary["ticket_count"] as? Int
        total = dictionary["total"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if created != nil{
            dictionary["created"] = created
        }
        if deliveryPrice != nil{
            dictionary["delivery_price"] = deliveryPrice
        }
        if deliveryType != nil{
            dictionary["delivery_type"] = deliveryType
        }
        if id != nil{
            dictionary["id"] = id
        }
        if message != nil{
            dictionary["message"] = message
        }
        if name != nil{
            dictionary["name"] = name
        }
        if orderId != nil{
            dictionary["order_id"] = orderId
        }
        if payDate != nil{
            dictionary["pay_date"] = payDate
        }
        if payType != nil{
            dictionary["pay_type"] = payType
        }
        if payUrl != nil{
            dictionary["pay_url"] = payUrl.toDictionary()
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if price != nil{
            dictionary["price"] = price
        }
        if reason != nil{
            dictionary["reason"] = reason
        }
        if status != nil{
            dictionary["status"] = status
        }
        if statusDesc != nil{
            dictionary["status_desc"] = statusDesc
        }
        if ticketCount != nil{
            dictionary["ticket_count"] = ticketCount
        }
        if total != nil{
            dictionary["total"] = total
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        created = aDecoder.decodeObjectForKey("created") as? String
        deliveryPrice = aDecoder.decodeObjectForKey("delivery_price") as? Int
        deliveryType = aDecoder.decodeObjectForKey("delivery_type") as? Int
        id = aDecoder.decodeObjectForKey("id") as? Int
        message = aDecoder.decodeObjectForKey("message") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        orderId = aDecoder.decodeObjectForKey("order_id") as? String
        payDate = aDecoder.decodeObjectForKey("pay_date") as? String
        payType = aDecoder.decodeObjectForKey("pay_type") as? Int
        payUrl = aDecoder.decodeObjectForKey("pay_url") as? PayUrl
        phone = aDecoder.decodeObjectForKey("phone") as? String
        price = aDecoder.decodeObjectForKey("price") as? Int
        reason = aDecoder.decodeObjectForKey("reason") as? String
        status = aDecoder.decodeObjectForKey("status") as? Int
        statusDesc = aDecoder.decodeObjectForKey("status_desc") as? String
        ticketCount = aDecoder.decodeObjectForKey("ticket_count") as? Int
        total = aDecoder.decodeObjectForKey("total") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if created != nil{
            aCoder.encodeObject(created, forKey: "created")
        }
        if deliveryPrice != nil{
            aCoder.encodeObject(deliveryPrice, forKey: "delivery_price")
        }
        if deliveryType != nil{
            aCoder.encodeObject(deliveryType, forKey: "delivery_type")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if message != nil{
            aCoder.encodeObject(message, forKey: "message")
        }
        if name != nil{
            aCoder.encodeObject(name, forKey: "name")
        }
        if orderId != nil{
            aCoder.encodeObject(orderId, forKey: "order_id")
        }
        if payDate != nil{
            aCoder.encodeObject(payDate, forKey: "pay_date")
        }
        if payType != nil{
            aCoder.encodeObject(payType, forKey: "pay_type")
        }
        if payUrl != nil{
            aCoder.encodeObject(payUrl, forKey: "pay_url")
        }
        if phone != nil{
            aCoder.encodeObject(phone, forKey: "phone")
        }
        if price != nil{
            aCoder.encodeObject(price, forKey: "price")
        }
        if reason != nil{
            aCoder.encodeObject(reason, forKey: "reason")
        }
        if status != nil{
            aCoder.encodeObject(status, forKey: "status")
        }
        if statusDesc != nil{
            aCoder.encodeObject(statusDesc, forKey: "status_desc")
        }
        if ticketCount != nil{
            aCoder.encodeObject(ticketCount, forKey: "ticket_count")
        }
        if total != nil{
            aCoder.encodeObject(total, forKey: "total")
        }
        
    }
    
}
