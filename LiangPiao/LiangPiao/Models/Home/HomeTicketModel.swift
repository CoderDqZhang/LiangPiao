//
//  HomeTicketModel.swift
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
    var id : Int!
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
        id = dictionary["id"] as? Int
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
        address = aDecoder.decodeObjectForKey("address") as? String
        city = aDecoder.decodeObjectForKey("city") as? String
        id = aDecoder.decodeObjectForKey("id") as? Int
        image = aDecoder.decodeObjectForKey("image") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        phone = aDecoder.decodeObjectForKey("phone") as? String
        regions = aDecoder.decodeObjectForKey("regions") as? String
        
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
        if city != nil{
            aCoder.encodeObject(city, forKey: "city")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if image != nil{
            aCoder.encodeObject(image, forKey: "image")
        }
        if name != nil{
            aCoder.encodeObject(name, forKey: "name")
        }
        if phone != nil{
            aCoder.encodeObject(phone, forKey: "phone")
        }
        if regions != nil{
            aCoder.encodeObject(regions, forKey: "regions")
        }
        
    }
    
}

class Category : NSObject, NSCoding{
    
    var id : Int!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? Int
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
        id = aDecoder.decodeObjectForKey("id") as? Int
        name = aDecoder.decodeObjectForKey("name") as? String
        
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
    }
    
}

class HomeTicketModel : NSObject, NSCoding{
    
    var category : Category!
    var city : String!
    var cover : String!
    var id : Int!
    var minDiscount : String!
    var minPrice : Int!
    var sessionCount : Int!
    var showDate : String!
    var ticketCount : Int!
    var ticketStatus : Int!
    var isFavorite : Bool!
    var title : String!
    var venue : Venue!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        if let categoryData = dictionary["category"] as? NSDictionary{
            category = Category(fromDictionary: categoryData)
        }
        city = dictionary["city"] as? String
        cover = dictionary["cover"] as? String
        id = dictionary["id"] as? Int
        minDiscount = dictionary["min_discount"] as? String
        minPrice = dictionary["min_price"] as? Int
        sessionCount = dictionary["session_count"] as? Int
        showDate = dictionary["show_date"] as? String
        isFavorite = dictionary["is_favorite"] as? Bool
        ticketCount = dictionary["ticket_count"] as? Int
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
        if sessionCount != nil{
            dictionary["session_count"] = sessionCount
        }
        if showDate != nil{
            dictionary["show_date"] = showDate
        }
        if ticketCount != nil{
            dictionary["ticket_count"] = ticketCount
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
        category = aDecoder.decodeObjectForKey("category") as? Category
        city = aDecoder.decodeObjectForKey("city") as? String
        cover = aDecoder.decodeObjectForKey("cover") as? String
        id = aDecoder.decodeObjectForKey("id") as? Int
        isFavorite = aDecoder.decodeObjectForKey("is_favorite") as? Bool
        minDiscount = aDecoder.decodeObjectForKey("min_discount") as? String
        minPrice = aDecoder.decodeObjectForKey("min_price") as? Int
        sessionCount = aDecoder.decodeObjectForKey("session_count") as? Int
        showDate = aDecoder.decodeObjectForKey("show_date") as? String
        ticketCount = aDecoder.decodeObjectForKey("ticket_count") as? Int
        ticketStatus = aDecoder.decodeObjectForKey("ticket_status") as? Int
        title = aDecoder.decodeObjectForKey("title") as? String
        venue = aDecoder.decodeObjectForKey("venue") as? Venue
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encodeObject(category, forKey: "category")
        }
        if city != nil{
            aCoder.encodeObject(city, forKey: "city")
        }
        if cover != nil{
            aCoder.encodeObject(cover, forKey: "cover")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if isFavorite != nil{
            aCoder.encodeObject(isFavorite, forKey: "is_favorite")
        }
        if minDiscount != nil{
            aCoder.encodeObject(minDiscount, forKey: "min_discount")
        }
        if minPrice != nil{
            aCoder.encodeObject(minPrice, forKey: "min_price")
        }
        if sessionCount != nil{
            aCoder.encodeObject(sessionCount, forKey: "session_count")
        }
        if showDate != nil{
            aCoder.encodeObject(showDate, forKey: "show_date")
        }
        if ticketCount != nil{
            aCoder.encodeObject(ticketCount, forKey: "ticket_count")
        }
        if ticketStatus != nil{
            aCoder.encodeObject(ticketStatus, forKey: "ticket_status")
        }
        if title != nil{
            aCoder.encodeObject(title, forKey: "title")
        }
        if venue != nil{
            aCoder.encodeObject(venue, forKey: "venue")
        }
        
    }
    
}
