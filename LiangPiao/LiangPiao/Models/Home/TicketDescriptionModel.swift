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
        session = aDecoder.decodeObject(forKey: "session") as? ShowSessionModel
        show = aDecoder.decodeObject(forKey: "show") as? TicketShowModel
        ticketList = aDecoder.decodeObject(forKey: "ticket_list") as? [TicketList]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if session != nil{
            aCoder.encode(session, forKey: "session")
        }
        if show != nil{
            aCoder.encode(show, forKey: "show")
        }
        if ticketList != nil{
            aCoder.encode(ticketList, forKey: "ticket_list")
        }
        
    }
    
}

class Supplier : NSObject, NSCoding{
    
    var id : Int64!
    var mobileNum : String!
    var username : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? Int64
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
            dictionary["id"] = id
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
        id = aDecoder.decodeObject(forKey: "id") as? Int64
        mobileNum = aDecoder.decodeObject(forKey: "mobile_num") as? String
        username = aDecoder.decodeObject(forKey: "username") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if mobileNum != nil{
            aCoder.encode(mobileNum, forKey: "mobile_num")
        }
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }
        
    }
    
}

class TicketList : NSObject, NSCoding{
    
    var deliveryPrice : Int!
    var deliveryPriceSf : Int!
    var deliveryType : String!
    var discount : String!
    var id : Int64!
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
    var sellCategory : Int!
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
        id = dictionary["id"] as? Int64
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
        sellCategory = dictionary["sell_category"] as? Int
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
        if sellCategory != nil{
            dictionary["sell_category"] = sellCategory
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
        deliveryPrice = aDecoder.decodeObject(forKey: "delivery_price") as? Int
        deliveryPriceSf = aDecoder.decodeObject(forKey: "delivery_price_sf") as? Int
        deliveryType = aDecoder.decodeObject(forKey: "delivery_type") as? String
        discount = aDecoder.decodeObject(forKey: "discount") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int64
        originalTicket = aDecoder.decodeObject(forKey: "original_ticket") as? OriginalTicket
        price = aDecoder.decodeObject(forKey: "price") as? Int
        region = aDecoder.decodeObject(forKey: "region") as? String
        remainCount = aDecoder.decodeObject(forKey: "remain_count") as? Int
        row = aDecoder.decodeObject(forKey: "row") as? String
        sceneGetTicketAddress = aDecoder.decodeObject(forKey: "scene_get_ticket_address") as? String
        sceneGetTicketDate = aDecoder.decodeObject(forKey: "scene_get_ticket_date") as? String
        sceneGetTicketPhone = aDecoder.decodeObject(forKey: "scene_get_ticket_phone") as? String
        seatType = aDecoder.decodeObject(forKey: "seat_type") as? Int
        selfGetTicketAddress = aDecoder.decodeObject(forKey: "self_get_ticket_address") as? String
        selfGetTicketDate = aDecoder.decodeObject(forKey: "self_get_ticket_date") as? String
        selfGetTicketPhone = aDecoder.decodeObject(forKey: "self_get_ticket_phone") as? String
        sellCategory = aDecoder.decodeObject(forKey: "sell_category") as? Int
        sellType = aDecoder.decodeObject(forKey: "sell_type") as? Int
        soldCount = aDecoder.decodeObject(forKey: "sold_count") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? Int
        statusDesc = aDecoder.decodeObject(forKey: "status_desc") as? String
        supplier = aDecoder.decodeObject(forKey: "supplier") as? Supplier
        ticketCount = aDecoder.decodeObject(forKey: "ticket_count") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if deliveryPrice != nil{
            aCoder.encode(deliveryPrice, forKey: "delivery_price")
        }
        if deliveryPriceSf != nil{
            aCoder.encode(deliveryPriceSf, forKey: "delivery_price_sf")
        }
        if deliveryType != nil{
            aCoder.encode(deliveryType, forKey: "delivery_type")
        }
        if discount != nil{
            aCoder.encode(discount, forKey: "discount")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if originalTicket != nil{
            aCoder.encode(originalTicket, forKey: "original_ticket")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if region != nil{
            aCoder.encode(region, forKey: "region")
        }
        if remainCount != nil{
            aCoder.encode(remainCount, forKey: "remain_count")
        }
        if row != nil{
            aCoder.encode(row, forKey: "row")
        }
        if sceneGetTicketAddress != nil{
            aCoder.encode(sceneGetTicketAddress, forKey: "scene_get_ticket_address")
        }
        if sceneGetTicketDate != nil{
            aCoder.encode(sceneGetTicketDate, forKey: "scene_get_ticket_date")
        }
        if sceneGetTicketPhone != nil{
            aCoder.encode(sceneGetTicketPhone, forKey: "scene_get_ticket_phone")
        }
        if seatType != nil{
            aCoder.encode(seatType, forKey: "seat_type")
        }
        if selfGetTicketAddress != nil{
            aCoder.encode(selfGetTicketAddress, forKey: "self_get_ticket_address")
        }
        if selfGetTicketDate != nil{
            aCoder.encode(selfGetTicketDate, forKey: "self_get_ticket_date")
        }
        if selfGetTicketPhone != nil{
            aCoder.encode(selfGetTicketPhone, forKey: "self_get_ticket_phone")
        }
        if sellCategory != nil{
            aCoder.encode(sellCategory, forKey: "sell_category")
        }
        if sellType != nil{
            aCoder.encode(sellType, forKey: "sell_type")
        }
        if soldCount != nil{
            aCoder.encode(soldCount, forKey: "sold_count")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if statusDesc != nil{
            aCoder.encode(statusDesc, forKey: "status_desc")
        }
        if supplier != nil{
            aCoder.encode(supplier, forKey: "supplier")
        }
        if ticketCount != nil{
            aCoder.encode(ticketCount, forKey: "ticket_count")
        }
        
    }
    
}

class OriginalTicket : NSObject, NSCoding{
    
    var id : Int64!
    var name : String!
    var price : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? Int64
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
        id = aDecoder.decodeObject(forKey: "id") as? Int64
        name = aDecoder.decodeObject(forKey: "name") as? String
        price = aDecoder.decodeObject(forKey: "price") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        
    }
    
}
