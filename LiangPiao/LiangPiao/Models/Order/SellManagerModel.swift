//
//  SellManagerModel.swift
//  LiangPiao
//
//  Created by Zhang on 09/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SellManagerModel : NSObject, NSCoding{
    
    var category : Category!
    var city : String!
    var cover : String!
    var id : Int!
    var minDiscount : String!
    var minPrice : Int!
    var sessionCount : Int!
    var sessionList : [SessionList]!
    var showDate : String!
    var ticketCount : Int!
    var ticketStatus : Int!
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
        sessionList = [SessionList]()
        if let sessionListArray = dictionary["session_list"] as? [NSDictionary]{
            for dic in sessionListArray{
                let value = SessionList(fromDictionary: dic)
                sessionList.append(value)
            }
        }
        showDate = dictionary["show_date"] as? String
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
        if minDiscount != nil{
            dictionary["min_discount"] = minDiscount
        }
        if minPrice != nil{
            dictionary["min_price"] = minPrice
        }
        if sessionCount != nil{
            dictionary["session_count"] = sessionCount
        }
        if sessionList != nil{
            var dictionaryElements = [NSDictionary]()
            for sessionListElement in sessionList {
                dictionaryElements.append(sessionListElement.toDictionary())
            }
            dictionary["session_list"] = dictionaryElements
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
        minDiscount = aDecoder.decodeObjectForKey("min_discount") as? String
        minPrice = aDecoder.decodeObjectForKey("min_price") as? Int
        sessionCount = aDecoder.decodeObjectForKey("session_count") as? Int
        sessionList = aDecoder.decodeObjectForKey("session_list") as? [SessionList]
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
        if minDiscount != nil{
            aCoder.encodeObject(minDiscount, forKey: "min_discount")
        }
        if minPrice != nil{
            aCoder.encodeObject(minPrice, forKey: "min_price")
        }
        if sessionCount != nil{
            aCoder.encodeObject(sessionCount, forKey: "session_count")
        }
        if sessionList != nil{
            aCoder.encodeObject(sessionList, forKey: "session_list")
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

class SessionList : NSObject, NSCoding{
    
    var endTime : String!
    var id : Int!
    var minDiscount : String!
    var minPrice : Int!
    var name : String!
    var openRegions : String!
    var otherRegions : String!
    var startTime : String!
    var ticketCount : Int!
    var ticketList : [TicketList]!
    var ticketStatus : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        endTime = dictionary["end_time"] as? String
        id = dictionary["id"] as? Int
        minDiscount = dictionary["min_discount"] as? String
        minPrice = dictionary["min_price"] as? Int
        name = dictionary["name"] as? String
        openRegions = dictionary["open_regions"] as? String
        otherRegions = dictionary["other_regions"] as? String
        startTime = dictionary["start_time"] as? String
        ticketCount = dictionary["ticket_count"] as? Int
        ticketList = [TicketList]()
        if let ticketListArray = dictionary["ticket_list"] as? [NSDictionary]{
            for dic in ticketListArray{
                let value = TicketList(fromDictionary: dic)
                ticketList.append(value)
            }
        }
        ticketStatus = dictionary["ticket_status"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if endTime != nil{
            dictionary["end_time"] = endTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if minDiscount != nil{
            dictionary["min_discount"] = minDiscount
        }
        if minPrice != nil{
            dictionary["min_price"] = minPrice
        }
        if name != nil{
            dictionary["name"] = name
        }
        if openRegions != nil{
            dictionary["open_regions"] = openRegions
        }
        if otherRegions != nil{
            dictionary["other_regions"] = otherRegions
        }
        if startTime != nil{
            dictionary["start_time"] = startTime
        }
        if ticketCount != nil{
            dictionary["ticket_count"] = ticketCount
        }
        if ticketList != nil{
            var dictionaryElements = [NSDictionary]()
            for ticketListElement in ticketList {
                dictionaryElements.append(ticketListElement.toDictionary())
            }
            dictionary["ticket_list"] = dictionaryElements
        }
        if ticketStatus != nil{
            dictionary["ticket_status"] = ticketStatus
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        endTime = aDecoder.decodeObjectForKey("end_time") as? String
        id = aDecoder.decodeObjectForKey("id") as? Int
        minDiscount = aDecoder.decodeObjectForKey("min_discount") as? String
        minPrice = aDecoder.decodeObjectForKey("min_price") as? Int
        name = aDecoder.decodeObjectForKey("name") as? String
        openRegions = aDecoder.decodeObjectForKey("open_regions") as? String
        otherRegions = aDecoder.decodeObjectForKey("other_regions") as? String
        startTime = aDecoder.decodeObjectForKey("start_time") as? String
        ticketCount = aDecoder.decodeObjectForKey("ticket_count") as? Int
        ticketList = aDecoder.decodeObjectForKey("ticket_list") as? [TicketList]
        ticketStatus = aDecoder.decodeObjectForKey("ticket_status") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if endTime != nil{
            aCoder.encodeObject(endTime, forKey: "end_time")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if minDiscount != nil{
            aCoder.encodeObject(minDiscount, forKey: "min_discount")
        }
        if minPrice != nil{
            aCoder.encodeObject(minPrice, forKey: "min_price")
        }
        if name != nil{
            aCoder.encodeObject(name, forKey: "name")
        }
        if openRegions != nil{
            aCoder.encodeObject(openRegions, forKey: "open_regions")
        }
        if otherRegions != nil{
            aCoder.encodeObject(otherRegions, forKey: "other_regions")
        }
        if startTime != nil{
            aCoder.encodeObject(startTime, forKey: "start_time")
        }
        if ticketCount != nil{
            aCoder.encodeObject(ticketCount, forKey: "ticket_count")
        }
        if ticketList != nil{
            aCoder.encodeObject(ticketList, forKey: "ticket_list")
        }
        if ticketStatus != nil{
            aCoder.encodeObject(ticketStatus, forKey: "ticket_status")
        }
        
    }
    
}
