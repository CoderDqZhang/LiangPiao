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
        appid = aDecoder.decodeObject(forKey: "appid") as? String
        noncestr = aDecoder.decodeObject(forKey: "noncestr") as? String
        packageField = aDecoder.decodeObject(forKey: "package") as? String
        partnerid = aDecoder.decodeObject(forKey: "partnerid") as? String
        prepayid = aDecoder.decodeObject(forKey: "prepayid") as? String
        sign = aDecoder.decodeObject(forKey: "sign") as? String
        timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if appid != nil{
            aCoder.encode(appid, forKey: "appid")
        }
        if noncestr != nil{
            aCoder.encode(noncestr, forKey: "noncestr")
        }
        if packageField != nil{
            aCoder.encode(packageField, forKey: "package")
        }
        if partnerid != nil{
            aCoder.encode(partnerid, forKey: "partnerid")
        }
        if prepayid != nil{
            aCoder.encode(prepayid, forKey: "prepayid")
        }
        if sign != nil{
            aCoder.encode(sign, forKey: "sign")
        }
        if timestamp != nil{
            aCoder.encode(timestamp, forKey: "timestamp")
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
        alipay = aDecoder.decodeObject(forKey: "alipay") as? String
        wxpay = aDecoder.decodeObject(forKey: "wxpay") as? Wxpay
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if alipay != nil{
            aCoder.encode(alipay, forKey: "alipay")
        }
        if wxpay != nil{
            aCoder.encode(wxpay, forKey: "wxpay")
        }
        
    }
    
}

class OrderList : NSObject, NSCoding{
    
    var address : AddressModel!
    var created : String!
    var deliveryPrice : Int!
    var deliveryType : Int!
    var expressInfo : ExpressInfo!
    var id : Int64!
    var message : String!
    var name : String!
    var orderId : String!
    var payDate : String!
    var payType : Int!
    var payUrl : PayUrl!
    var phone : String!
    var price : Int!
    var reason : String!
    var session : ShowSessionModel!
    var show : TicketShowModel!
    var status : Int!
    var statusDesc : String!
    var supplierStatusDesc : String!
    var ticket : TicketList!
    var remainCount : Int!
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
        if let expressInfoData = dictionary["express_info"] as? NSDictionary{
            expressInfo = ExpressInfo(fromDictionary: expressInfoData)
        }
        id = dictionary["id"]as? Int64
        message = dictionary["message"] as? String
        name = dictionary["name"] as? String
        orderId = dictionary["order_id"] as? String
        payDate = dictionary["pay_date"] as? String
        payType = dictionary["pay_type"] as? Int
        phone = dictionary["phone"] as? String
        price = dictionary["price"] as? Int
        reason = dictionary["reason"] as? String
        if let sessionData = dictionary["session"] as? NSDictionary{
            session = ShowSessionModel(fromDictionary: sessionData)
        }
        if let showData = dictionary["show"] as? NSDictionary{
            show = TicketShowModel(fromDictionary: showData)
        }
        if let payUrlData = dictionary["pay_url"] as? NSDictionary{
            payUrl = PayUrl(fromDictionary: payUrlData)
        }
        status = dictionary["status"] as? Int
        statusDesc = dictionary["status_desc"] as? String
        supplierStatusDesc = dictionary["supplier_status_desc"] as? String
        if let ticketData = dictionary["ticket"] as? NSDictionary{
            ticket = TicketList(fromDictionary: ticketData)
        }
        remainCount = dictionary["ticket_count"] as? Int
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
        if expressInfo != nil{
            dictionary["express_info"] = expressInfo.toDictionary()
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
        if supplierStatusDesc != nil{
            dictionary["supplier_status_desc"] = supplierStatusDesc
        }
        if ticket != nil{
            dictionary["ticket"] = ticket.toDictionary()
        }
        if remainCount != nil{
            dictionary["ticket_count"] = remainCount
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
        address = aDecoder.decodeObject(forKey: "address") as? AddressModel
        created = aDecoder.decodeObject(forKey: "created") as? String
        deliveryPrice = aDecoder.decodeObject(forKey: "delivery_price") as? Int
        deliveryType = aDecoder.decodeObject(forKey: "delivery_type") as? Int
        expressInfo = aDecoder.decodeObject(forKey: "express_info") as? ExpressInfo
        id = aDecoder.decodeObject(forKey: "id") as? Int64
        message = aDecoder.decodeObject(forKey: "message") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        orderId = aDecoder.decodeObject(forKey: "order_id") as? String
        payDate = aDecoder.decodeObject(forKey: "pay_date") as? String
        payType = aDecoder.decodeObject(forKey: "pay_type") as? Int
        payUrl = aDecoder.decodeObject(forKey: "pay_url") as? PayUrl
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        price = aDecoder.decodeObject(forKey: "price") as? Int
        reason = aDecoder.decodeObject(forKey: "reason") as? String
        session = aDecoder.decodeObject(forKey: "session") as? ShowSessionModel
        show = aDecoder.decodeObject(forKey: "show") as? TicketShowModel
        status = aDecoder.decodeObject(forKey: "status") as? Int
        statusDesc = aDecoder.decodeObject(forKey: "status_desc") as? String
        supplierStatusDesc = aDecoder.decodeObject(forKey: "supplier_status_desc") as? String
        ticket = aDecoder.decodeObject(forKey: "ticket") as? TicketList
        remainCount = aDecoder.decodeObject(forKey: "ticket_count") as? Int
        total = aDecoder.decodeObject(forKey: "total") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if created != nil{
            aCoder.encode(created, forKey: "created")
        }
        if deliveryPrice != nil{
            aCoder.encode(deliveryPrice, forKey: "delivery_price")
        }
        if deliveryType != nil{
            aCoder.encode(deliveryType, forKey: "delivery_type")
        }
        if expressInfo != nil{
            aCoder.encode(expressInfo, forKey: "express_info")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if orderId != nil{
            aCoder.encode(orderId, forKey: "order_id")
        }
        if payDate != nil{
            aCoder.encode(payDate, forKey: "pay_date")
        }
        if payType != nil{
            aCoder.encode(payType, forKey: "pay_type")
        }
        if payUrl != nil{
            aCoder.encode(payUrl, forKey: "pay_url")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if reason != nil{
            aCoder.encode(reason, forKey: "reason")
        }
        if session != nil{
            aCoder.encode(session, forKey: "session")
        }
        if show != nil{
            aCoder.encode(show, forKey: "show")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if statusDesc != nil{
            aCoder.encode(statusDesc, forKey: "status_desc")
        }
        if supplierStatusDesc != nil{
            aCoder.encode(supplierStatusDesc, forKey: "supplier_status_desc")
        }
        if ticket != nil{
            aCoder.encode(ticket, forKey: "ticket")
        }
        if remainCount != nil{
            aCoder.encode(remainCount, forKey: "ticket_count")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        
    }
    
}

class ExpressInfo : NSObject, NSCoding{
    
    var expressName : String!
    var expressNum : String!
    var id : Int64!
    var orderId : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        expressName = dictionary["express_name"] as? String
        expressNum = dictionary["express_num"] as? String
        id = dictionary["id"] as? Int64
        orderId = dictionary["order_id"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if expressName != nil{
            dictionary["express_name"] = expressName
        }
        if expressNum != nil{
            dictionary["express_num"] = expressNum
        }
        if id != nil{
            dictionary["id"] = id
        }
        if orderId != nil{
            dictionary["order_id"] = orderId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        expressName = aDecoder.decodeObject(forKey: "express_name") as? String
        expressNum = aDecoder.decodeObject(forKey: "express_num") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int64
        orderId = aDecoder.decodeObject(forKey: "order_id") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if expressName != nil{
            aCoder.encode(expressName, forKey: "express_name")
        }
        if expressNum != nil{
            aCoder.encode(expressNum, forKey: "express_num")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if orderId != nil{
            aCoder.encode(orderId, forKey: "order_id")
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
        hasNext = aDecoder.decodeObject(forKey: "has_next") as? Bool
        nextPage = aDecoder.decodeObject(forKey: "next_page") as? Int
        orderList = aDecoder.decodeObject(forKey: "order_list") as? [OrderList]
        total = aDecoder.decodeObject(forKey: "total") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if hasNext != nil{
            aCoder.encode(hasNext, forKey: "has_next")
        }
        if nextPage != nil{
            aCoder.encode(nextPage, forKey: "next_page")
        }
        if orderList != nil{
            aCoder.encode(orderList, forKey: "order_list")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        
    }
    
}
