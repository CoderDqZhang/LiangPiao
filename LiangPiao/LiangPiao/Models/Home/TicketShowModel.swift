//
//  TicketShowModel.swift
//  LiangPiao
//
//  Created by Zhang on 22/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//


//
//	RootClass.swift
//
//	Create by Zhang on 22/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class Venue : NSObject, NSCoding{
    
    var address : String!
    var city : String!
    var id : Int64!
    var image : String!
    var name : String!
    var phone : String!
    var regions : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        address = dictionary["address"] as? String
        city = dictionary["city"] as? String
        id = dictionary["id"] as? Int64
        image = dictionary["image"] as? String
        name = dictionary["name"] as? String
        phone = dictionary["phone"] as? String
        regions = dictionary["regions"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if address != nil{
            dictionary["address"] = address
        }
        if city != nil{
            dictionary["city"] = city
        }
        if id != nil{
            dictionary["id"] = id
        }
        if image != nil{
            dictionary["image"] = image
        }
        if name != nil{
            dictionary["name"] = name
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if regions != nil{
            dictionary["regions"] = regions
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int64
        image = aDecoder.decodeObject(forKey: "image") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        regions = aDecoder.decodeObject(forKey: "regions") as? String
        
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
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if regions != nil{
            aCoder.encode(regions, forKey: "regions")
        }
        
    }
    
}

class Category : NSObject, NSCoding{
    
    var id : Int64!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? Int64
        name = dictionary["name"] as? String
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
    }
    
}

class TicketShowModel : NSObject, NSCoding{
    
    var category : Category!
    var city : String!
    var cover : String!
    var id : Int64!
    var minDiscount : String!
    var minPrice : Int!
    var maxPrice : Int!
    var session : ShowSessionModel!
    var sessionList : [ShowSessionModel]!
    var sessionCount : Int!
    var showDate : String!
    var remainCount : Int!
    var ticketStatus : Int!
    var isFavorite : Bool!
    var title : String!
    var venue : Venue!
    var soldCount : Int!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        if let categoryData = dictionary["category"] as? NSDictionary{
            category = Category(fromDictionary: categoryData)
        }
        city = dictionary["city"] as? String
        cover = dictionary["cover"] as? String
        id = dictionary["id"] as! Int64
        minDiscount = dictionary["min_discount"] as? String
        minPrice = dictionary["min_price"] as? Int
        maxPrice = dictionary["max_price"] as? Int
        if let sessionData = dictionary["session"] as? NSDictionary{
            session = ShowSessionModel(fromDictionary: sessionData)
        }
        sessionList = [ShowSessionModel]()
        if let sessionListArray = dictionary["session_list"] as? [NSDictionary]{
            for dic in sessionListArray{
                let value = ShowSessionModel(fromDictionary: dic)
                sessionList.append(value)
            }
        }
        sessionCount = dictionary["session_count"] as? Int
        showDate = dictionary["show_date"] as? String
        isFavorite = dictionary["is_favorite"] as? Bool
        remainCount = dictionary["ticket_count"] as? Int
        ticketStatus = dictionary["ticket_status"] as? Int
        title = dictionary["title"] as? String
        if let venueData = dictionary["venue"] as? NSDictionary{
            venue = Venue(fromDictionary: venueData)
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if category != nil{
            dictionary["category"] = category.toDictionary()
        }
        if city != nil{
            dictionary["city"] = city
        }
        if cover != nil{
            dictionary["cover"] = cover
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isFavorite != nil{
            dictionary["is_favorite"] = isFavorite
        }
        if minDiscount != nil{
            dictionary["min_discount"] = minDiscount
        }
        if minPrice != nil{
            dictionary["min_price"] = minPrice
        }
        if maxPrice != nil{
            dictionary["max_price"] = maxPrice
        }
        if session != nil{
            dictionary["session"] = session.toDictionary()
        }
        if sessionList != nil{
            var dictionaryElements = [NSDictionary]()
            for sessionListElement in sessionList {
                dictionaryElements.append(sessionListElement.toDictionary())
            }
            dictionary["session_list"] = dictionaryElements
        }
        if sessionCount != nil{
            dictionary["session_count"] = sessionCount
        }
        if showDate != nil{
            dictionary["show_date"] = showDate
        }
        if remainCount != nil{
            dictionary["ticket_count"] = remainCount
        }
        if ticketStatus != nil{
            dictionary["ticket_status"] = ticketStatus
        }
        if title != nil{
            dictionary["title"] = title
        }
        if venue != nil{
            dictionary["venue"] = venue.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        category = aDecoder.decodeObject(forKey: "category") as? Category
        city = aDecoder.decodeObject(forKey: "city") as? String
        cover = aDecoder.decodeObject(forKey: "cover") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int64
        isFavorite = aDecoder.decodeObject(forKey: "is_favorite") as? Bool
        minDiscount = aDecoder.decodeObject(forKey: "min_discount") as? String
        minPrice = aDecoder.decodeObject(forKey: "min_price") as? Int
        maxPrice = aDecoder.decodeObject(forKey: "max_price") as? Int
        session = aDecoder.decodeObject(forKey: "session") as? ShowSessionModel
        sessionList = aDecoder.decodeObject(forKey: "session_list") as? [ShowSessionModel]
        sessionCount = aDecoder.decodeObject(forKey: "session_count") as? Int
        showDate = aDecoder.decodeObject(forKey: "show_date") as? String
        remainCount = aDecoder.decodeObject(forKey: "ticket_count") as? Int
        ticketStatus = aDecoder.decodeObject(forKey: "ticket_status") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
        venue = aDecoder.decodeObject(forKey: "venue") as? Venue
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if cover != nil{
            aCoder.encode(cover, forKey: "cover")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if maxPrice != nil{
            aCoder.encode(maxPrice, forKey: "max_price")
        }
        if isFavorite != nil{
            aCoder.encode(isFavorite, forKey: "is_favorite")
        }
        if minDiscount != nil{
            aCoder.encode(minDiscount, forKey: "min_discount")
        }
        if minPrice != nil{
            aCoder.encode(minPrice, forKey: "min_price")
        }
        if session != nil{
            aCoder.encode(session, forKey: "session")
        }
        if sessionList != nil{
            aCoder.encode(sessionList, forKey: "session_list")
        }
        if sessionCount != nil{
            aCoder.encode(sessionCount, forKey: "session_count")
        }
        if showDate != nil{
            aCoder.encode(showDate, forKey: "show_date")
        }
        if remainCount != nil{
            aCoder.encode(remainCount, forKey: "ticket_count")
        }
        if ticketStatus != nil{
            aCoder.encode(ticketStatus, forKey: "ticket_status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if venue != nil{
            aCoder.encode(venue, forKey: "venue")
        }
        
    }
    
}
