//
//  TicketDescriptionModel.swift
//  LiangPiao
//
//  Created by Zhang on 28/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketDescriptionModel : NSObject, NSCoding{
    
    var session : ShowSessionModel!
    var show : TicketShowModel!
    var ticketList : [TicketList]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        if let sessionData = dictionary["session"] as? NSDictionary{
            session = ShowSessionModel(fromDictionary: sessionData)
        }
        if let showData = dictionary["show"] as? NSDictionary{
            show = TicketShowModel(fromDictionary: showData)
        }
        ticketList = [TicketList]()
        if let ticketListArray = dictionary["ticket_list"] as? [NSDictionary]{
            for dic in ticketListArray{
                let value = TicketList(fromDictionary: dic)
                ticketList.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if session != nil{
            dictionary["session"] = session.toDictionary()
        }
        if show != nil{
            dictionary["show"] = show.toDictionary()
        }
        if ticketList != nil{
            var dictionaryElements = [NSDictionary]()
            for ticketListElement in ticketList {
                dictionaryElements.append(ticketListElement.toDictionary())
            }
            dictionary["ticket_list"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        session = aDecoder.decodeObjectForKey("session") as? ShowSessionModel
        show = aDecoder.decodeObjectForKey("show") as? TicketShowModel
        ticketList = aDecoder.decodeObjectForKey("ticket_list") as? [TicketList]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if session != nil{
            aCoder.encodeObject(session, forKey: "session")
        }
        if show != nil{
            aCoder.encodeObject(show, forKey: "show")
        }
        if ticketList != nil{
            aCoder.encodeObject(ticketList, forKey: "ticket_list")
        }
        
    }
    
}

class Supplier : NSObject, NSCoding{
    
    var id : Int!
    var mobileNum : String!
    var username : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? Int
        mobileNum = dictionary["mobile_num"] as? String
        username = dictionary["username"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if id != nil{
            dictionary["id"] = id as? AnyObject
        }
        if mobileNum != nil{
            dictionary["mobile_num"] = mobileNum
        }
        if username != nil{
            dictionary["username"] = username
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObjectForKey("id") as? Int
        mobileNum = aDecoder.decodeObjectForKey("mobile_num") as? String
        username = aDecoder.decodeObjectForKey("username") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if mobileNum != nil{
            aCoder.encodeObject(mobileNum, forKey: "mobile_num")
        }
        if username != nil{
            aCoder.encodeObject(username, forKey: "username")
        }
        
    }
    
}

class TicketList : NSObject, NSCoding{
    
    var deliveryPrice : Int!
    var deliveryPriceSf : Int!
    var deliveryType : String!
    var discount : String!
    var id : Int!
    var originalTicket : OriginalTicket!
    var price : Int!
    var region : String!
    var remainCount : Int!
    var row : String!
    var sceneGetTicketAddress : String!
    var sceneGetTicketDate : String!
    var sceneGetTicketPhone : String!
    var seatType : Int!
    var selfGetTicketAddress : String!
    var selfGetTicketDate : String!
    var selfGetTicketPhone : String!
    var sellType : Int!
    var soldCount : Int!
    var status : Int!
    var statusDesc : String!
    var supplier : Supplier!
    var ticketCount : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        deliveryPrice = dictionary["delivery_price"] as? Int
        deliveryPriceSf = dictionary["delivery_price_sf"] as? Int
        deliveryType = dictionary["delivery_type"] as? String
        discount = dictionary["discount"] as? String
        id = dictionary["id"] as? Int
        if let originalTicketData = dictionary["original_ticket"] as? NSDictionary{
            originalTicket = OriginalTicket(fromDictionary: originalTicketData)
        }
        price = dictionary["price"] as? Int
        region = dictionary["region"] as? String
        remainCount = dictionary["remain_count"] as? Int
        row = dictionary["row"] as? String
        sceneGetTicketAddress = dictionary["scene_get_ticket_address"] as? String
        sceneGetTicketDate = dictionary["scene_get_ticket_date"] as? String
        sceneGetTicketPhone = dictionary["scene_get_ticket_phone"] as? String
        seatType = dictionary["seat_type"] as? Int
        selfGetTicketAddress = dictionary["self_get_ticket_address"] as? String
        selfGetTicketDate = dictionary["self_get_ticket_date"] as? String
        selfGetTicketPhone = dictionary["self_get_ticket_phone"] as? String
        sellType = dictionary["sell_type"] as? Int
        soldCount = dictionary["sold_count"] as? Int
        status = dictionary["status"] as? Int
        statusDesc = dictionary["status_desc"] as? String
        if let supplierData = dictionary["supplier"] as? NSDictionary{
            supplier = Supplier(fromDictionary: supplierData)
        }
        ticketCount = dictionary["ticket_count"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if deliveryPrice != nil{
            dictionary["delivery_price"] = deliveryPrice
        }
        if deliveryPriceSf != nil{
            dictionary["delivery_price_sf"] = deliveryPriceSf
        }
        if deliveryType != nil{
            dictionary["delivery_type"] = deliveryType
        }
        if discount != nil{
            dictionary["discount"] = discount
        }
        if id != nil{
            dictionary["id"] = id
        }
        if originalTicket != nil{
            dictionary["original_ticket"] = originalTicket.toDictionary()
        }
        if price != nil{
            dictionary["price"] = price
        }
        if region != nil{
            dictionary["region"] = region
        }
        if remainCount != nil{
            dictionary["remain_count"] = remainCount
        }
        if row != nil{
            dictionary["row"] = row
        }
        if sceneGetTicketAddress != nil{
            dictionary["scene_get_ticket_address"] = sceneGetTicketAddress
        }
        if sceneGetTicketDate != nil{
            dictionary["scene_get_ticket_date"] = sceneGetTicketDate
        }
        if sceneGetTicketPhone != nil{
            dictionary["scene_get_ticket_phone"] = sceneGetTicketPhone
        }
        if seatType != nil{
            dictionary["seat_type"] = seatType
        }
        if selfGetTicketAddress != nil{
            dictionary["self_get_ticket_address"] = selfGetTicketAddress
        }
        if selfGetTicketDate != nil{
            dictionary["self_get_ticket_date"] = selfGetTicketDate
        }
        if selfGetTicketPhone != nil{
            dictionary["self_get_ticket_phone"] = selfGetTicketPhone
        }
        if sellType != nil{
            dictionary["sell_type"] = sellType
        }
        if soldCount != nil{
            dictionary["sold_count"] = soldCount
        }
        if status != nil{
            dictionary["status"] = status
        }
        if statusDesc != nil{
            dictionary["status_desc"] = statusDesc
        }
        if supplier != nil{
            dictionary["supplier"] = supplier.toDictionary()
        }
        if ticketCount != nil{
            dictionary["ticket_count"] = ticketCount
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        deliveryPrice = aDecoder.decodeObjectForKey("delivery_price") as? Int
        deliveryPriceSf = aDecoder.decodeObjectForKey("delivery_price_sf") as? Int
        deliveryType = aDecoder.decodeObjectForKey("delivery_type") as? String
        discount = aDecoder.decodeObjectForKey("discount") as? String
        id = aDecoder.decodeObjectForKey("id") as? Int
        originalTicket = aDecoder.decodeObjectForKey("original_ticket") as? OriginalTicket
        price = aDecoder.decodeObjectForKey("price") as? Int
        region = aDecoder.decodeObjectForKey("region") as? String
        remainCount = aDecoder.decodeObjectForKey("remain_count") as? Int
        row = aDecoder.decodeObjectForKey("row") as? String
        sceneGetTicketAddress = aDecoder.decodeObjectForKey("scene_get_ticket_address") as? String
        sceneGetTicketDate = aDecoder.decodeObjectForKey("scene_get_ticket_date") as? String
        sceneGetTicketPhone = aDecoder.decodeObjectForKey("scene_get_ticket_phone") as? String
        seatType = aDecoder.decodeObjectForKey("seat_type") as? Int
        selfGetTicketAddress = aDecoder.decodeObjectForKey("self_get_ticket_address") as? String
        selfGetTicketDate = aDecoder.decodeObjectForKey("self_get_ticket_date") as? String
        selfGetTicketPhone = aDecoder.decodeObjectForKey("self_get_ticket_phone") as? String
        sellType = aDecoder.decodeObjectForKey("sell_type") as? Int
        soldCount = aDecoder.decodeObjectForKey("sold_count") as? Int
        status = aDecoder.decodeObjectForKey("status") as? Int
        statusDesc = aDecoder.decodeObjectForKey("status_desc") as? String
        supplier = aDecoder.decodeObjectForKey("supplier") as? Supplier
        ticketCount = aDecoder.decodeObjectForKey("ticket_count") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if deliveryPrice != nil{
            aCoder.encodeObject(deliveryPrice, forKey: "delivery_price")
        }
        if deliveryPriceSf != nil{
            aCoder.encodeObject(deliveryPriceSf, forKey: "delivery_price_sf")
        }
        if deliveryType != nil{
            aCoder.encodeObject(deliveryType, forKey: "delivery_type")
        }
        if discount != nil{
            aCoder.encodeObject(discount, forKey: "discount")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if originalTicket != nil{
            aCoder.encodeObject(originalTicket, forKey: "original_ticket")
        }
        if price != nil{
            aCoder.encodeObject(price, forKey: "price")
        }
        if region != nil{
            aCoder.encodeObject(region, forKey: "region")
        }
        if remainCount != nil{
            aCoder.encodeObject(remainCount, forKey: "remain_count")
        }
        if row != nil{
            aCoder.encodeObject(row, forKey: "row")
        }
        if sceneGetTicketAddress != nil{
            aCoder.encodeObject(sceneGetTicketAddress, forKey: "scene_get_ticket_address")
        }
        if sceneGetTicketDate != nil{
            aCoder.encodeObject(sceneGetTicketDate, forKey: "scene_get_ticket_date")
        }
        if sceneGetTicketPhone != nil{
            aCoder.encodeObject(sceneGetTicketPhone, forKey: "scene_get_ticket_phone")
        }
        if seatType != nil{
            aCoder.encodeObject(seatType, forKey: "seat_type")
        }
        if selfGetTicketAddress != nil{
            aCoder.encodeObject(selfGetTicketAddress, forKey: "self_get_ticket_address")
        }
        if selfGetTicketDate != nil{
            aCoder.encodeObject(selfGetTicketDate, forKey: "self_get_ticket_date")
        }
        if selfGetTicketPhone != nil{
            aCoder.encodeObject(selfGetTicketPhone, forKey: "self_get_ticket_phone")
        }
        if sellType != nil{
            aCoder.encodeObject(sellType, forKey: "sell_type")
        }
        if soldCount != nil{
            aCoder.encodeObject(soldCount, forKey: "sold_count")
        }
        if status != nil{
            aCoder.encodeObject(status, forKey: "status")
        }
        if statusDesc != nil{
            aCoder.encodeObject(statusDesc, forKey: "status_desc")
        }
        if supplier != nil{
            aCoder.encodeObject(supplier, forKey: "supplier")
        }
        if ticketCount != nil{
            aCoder.encodeObject(ticketCount, forKey: "ticket_count")
        }
        
    }
    
}

class OriginalTicket : NSObject, NSCoding{
    
    var id : Int!
    var name : String!
    var price : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        price = dictionary["price"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if price != nil{
            dictionary["price"] = price
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObjectForKey("id") as? Int
        name = aDecoder.decodeObjectForKey("name") as? String
        price = aDecoder.decodeObjectForKey("price") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if name != nil{
            aCoder.encodeObject(name, forKey: "name")
        }
        if price != nil{
            aCoder.encodeObject(price, forKey: "price")
        }
        
    }
    
}
