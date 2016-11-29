//
//  OrderListModel.swift
//  LiangPiao
//
//  Created by Zhang on 30/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderList : NSObject, NSCoding{
    
    var created : String!
    var deliveryPrice : Int!
    var deliveryType : Int!
    var id : Int!
    var message : String!
    var name : String!
    var orderId : String!
    var payDate : String!
    var payType : Int!
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
        created = aDecoder.decodeObjectForKey("created") as? String
        deliveryPrice = aDecoder.decodeObjectForKey("delivery_price") as? Int
        deliveryType = aDecoder.decodeObjectForKey("delivery_type") as? Int
        id = aDecoder.decodeObjectForKey("id") as? Int
        message = aDecoder.decodeObjectForKey("message") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        orderId = aDecoder.decodeObjectForKey("order_id") as? String
        payDate = aDecoder.decodeObjectForKey("pay_date") as? String
        payType = aDecoder.decodeObjectForKey("pay_type") as? Int
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
