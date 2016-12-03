//
//  OrderListModel.swift
//  LiangPiao
//
//  Created by Zhang on 30/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class Wxpay : NSObject, NSCoding{
    
    var appid : String!
    var noncestr : String!
    var packageField : String!
    var partnerid : String!
    var prepayid : String!
    var sign : String!
    var timestamp : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        appid = dictionary["appid"] as? String
        noncestr = dictionary["noncestr"] as? String
        packageField = dictionary["package"] as? String
        partnerid = dictionary["partnerid"] as? String
        prepayid = dictionary["prepayid"] as? String
        sign = dictionary["sign"] as? String
        timestamp = dictionary["timestamp"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if appid != nil{
            dictionary["appid"] = appid
        }
        if noncestr != nil{
            dictionary["noncestr"] = noncestr
        }
        if packageField != nil{
            dictionary["package"] = packageField
        }
        if partnerid != nil{
            dictionary["partnerid"] = partnerid
        }
        if prepayid != nil{
            dictionary["prepayid"] = prepayid
        }
        if sign != nil{
            dictionary["sign"] = sign
        }
        if timestamp != nil{
            dictionary["timestamp"] = timestamp
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        appid = aDecoder.decodeObjectForKey("appid") as? String
        noncestr = aDecoder.decodeObjectForKey("noncestr") as? String
        packageField = aDecoder.decodeObjectForKey("package") as? String
        partnerid = aDecoder.decodeObjectForKey("partnerid") as? String
        prepayid = aDecoder.decodeObjectForKey("prepayid") as? String
        sign = aDecoder.decodeObjectForKey("sign") as? String
        timestamp = aDecoder.decodeObjectForKey("timestamp") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if appid != nil{
            aCoder.encodeObject(appid, forKey: "appid")
        }
        if noncestr != nil{
            aCoder.encodeObject(noncestr, forKey: "noncestr")
        }
        if packageField != nil{
            aCoder.encodeObject(packageField, forKey: "package")
        }
        if partnerid != nil{
            aCoder.encodeObject(partnerid, forKey: "partnerid")
        }
        if prepayid != nil{
            aCoder.encodeObject(prepayid, forKey: "prepayid")
        }
        if sign != nil{
            aCoder.encodeObject(sign, forKey: "sign")
        }
        if timestamp != nil{
            aCoder.encodeObject(timestamp, forKey: "timestamp")
        }
        
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

class OrderList : NSObject, NSCoding{
    
    var address : AddressModel!
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
    var session : TicketSessionModel!
    var show : HomeTicketModel!
    var status : Int!
    var statusDesc : String!
    var ticket : TicketList!
    var ticketCount : Int!
    var total : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        if let addressData = dictionary["address"] as? NSDictionary{
            address = AddressModel(fromDictionary: addressData)
        }
        created = dictionary["created"] as? String
        deliveryPrice = dictionary["delivery_price"] as? Int
        deliveryType = dictionary["delivery_type"] as? Int
        id = dictionary["id"] as? Int
        message = dictionary["message"] as? String
        name = dictionary["name"] as? String
        orderId = dictionary["order_id"] as? String
        payDate = dictionary["pay_date"] as? String
        payType = dictionary["pay_type"] as? Int
        phone = dictionary["phone"] as? String
        price = dictionary["price"] as? Int
        reason = dictionary["reason"] as? String
        if let sessionData = dictionary["session"] as? NSDictionary{
            session = TicketSessionModel(fromDictionary: sessionData)
        }
        if let showData = dictionary["show"] as? NSDictionary{
            show = HomeTicketModel(fromDictionary: showData)
        }
        if let payUrlData = dictionary["pay_url"] as? NSDictionary{
            payUrl = PayUrl(fromDictionary: payUrlData)
        }
        status = dictionary["status"] as? Int
        statusDesc = dictionary["status_desc"] as? String
        if let ticketData = dictionary["ticket"] as? NSDictionary{
            ticket = TicketList(fromDictionary: ticketData)
        }
        ticketCount = dictionary["ticket_count"] as? Int
        total = dictionary["total"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if address != nil{
            dictionary["address"] = address.toDictionary()
        }
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
        if session != nil{
            dictionary["session"] = session.toDictionary()
        }
        if show != nil{
            dictionary["show"] = show.toDictionary()
        }
        if status != nil{
            dictionary["status"] = status
        }
        if statusDesc != nil{
            dictionary["status_desc"] = statusDesc
        }
        if ticket != nil{
            dictionary["ticket"] = ticket.toDictionary()
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
        address = aDecoder.decodeObjectForKey("address") as? AddressModel
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
        session = aDecoder.decodeObjectForKey("session") as? TicketSessionModel
        show = aDecoder.decodeObjectForKey("show") as? HomeTicketModel
        status = aDecoder.decodeObjectForKey("status") as? Int
        statusDesc = aDecoder.decodeObjectForKey("status_desc") as? String
        ticket = aDecoder.decodeObjectForKey("ticket") as? TicketList
        ticketCount = aDecoder.decodeObjectForKey("ticket_count") as? Int
        total = aDecoder.decodeObjectForKey("total") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encodeObject(address, forKey: "address")
        }
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
        if session != nil{
            aCoder.encodeObject(session, forKey: "session")
        }
        if show != nil{
            aCoder.encodeObject(show, forKey: "show")
        }
        if status != nil{
            aCoder.encodeObject(status, forKey: "status")
        }
        if statusDesc != nil{
            aCoder.encodeObject(statusDesc, forKey: "status_desc")
        }
        if ticket != nil{
            aCoder.encodeObject(ticket, forKey: "ticket")
        }
        if ticketCount != nil{
            aCoder.encodeObject(ticketCount, forKey: "ticket_count")
        }
        if total != nil{
            aCoder.encodeObject(total, forKey: "total")
        }
        
    }
    
}


class OrderListModel : NSObject, NSCoding{
    
    var hasNext : Bool!
    var nextPage : Int!
    var orderList : [OrderList]!
    var total : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        hasNext = dictionary["has_next"] as? Bool
        nextPage = dictionary["next_page"] as? Int
        orderList = [OrderList]()
        if let orderListArray = dictionary["order_list"] as? [NSDictionary]{
            for dic in orderListArray{
                let value = OrderList(fromDictionary: dic)
                orderList.append(value)
            }
        }
        total = dictionary["total"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if hasNext != nil{
            dictionary["has_next"] = hasNext
        }
        if nextPage != nil{
            dictionary["next_page"] = nextPage
        }
        if orderList != nil{
            var dictionaryElements = [NSDictionary]()
            for orderListElement in orderList {
                dictionaryElements.append(orderListElement.toDictionary())
            }
            dictionary["order_list"] = dictionaryElements
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
        hasNext = aDecoder.decodeObjectForKey("has_next") as? Bool
        nextPage = aDecoder.decodeObjectForKey("next_page") as? Int
        orderList = aDecoder.decodeObjectForKey("order_list") as? [OrderList]
        total = aDecoder.decodeObjectForKey("total") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if hasNext != nil{
            aCoder.encodeObject(hasNext, forKey: "has_next")
        }
        if nextPage != nil{
            aCoder.encodeObject(nextPage, forKey: "next_page")
        }
        if orderList != nil{
            aCoder.encodeObject(orderList, forKey: "order_list")
        }
        if total != nil{
            aCoder.encodeObject(total, forKey: "total")
        }
        
    }
    
}
