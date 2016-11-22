//
//	TicketSessionModel.swift
//
//	Create by Zhang on 22/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TicketSessionModel : NSObject, NSCoding{
    
    var endTime : String!
    var id : Int!
    var maxPrice : Int!
    var minPrice : Int!
    var name : String!
    var openRegions : String!
    var otherRegions : String!
    var startTime : String!
    var ticketStatus : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        endTime = dictionary["end_time"] as? String
        id = dictionary["id"] as? Int
        maxPrice = dictionary["max_price"] as? Int
        minPrice = dictionary["min_price"] as? Int
        name = dictionary["name"] as? String
        openRegions = dictionary["open_regions"] as? String
        otherRegions = dictionary["other_regions"] as? String
        startTime = dictionary["start_time"] as? String
        ticketStatus = dictionary["ticket_status"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if endTime != nil{
            dictionary["end_time"] = endTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if maxPrice != nil{
            dictionary["max_price"] = maxPrice
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
        maxPrice = aDecoder.decodeObjectForKey("max_price") as? Int
        minPrice = aDecoder.decodeObjectForKey("min_price") as? Int
        name = aDecoder.decodeObjectForKey("name") as? String
        openRegions = aDecoder.decodeObjectForKey("open_regions") as? String
        otherRegions = aDecoder.decodeObjectForKey("other_regions") as? String
        startTime = aDecoder.decodeObjectForKey("start_time") as? String
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
        if maxPrice != nil{
            aCoder.encodeObject(maxPrice, forKey: "max_price")
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
        if ticketStatus != nil{
            aCoder.encodeObject(ticketStatus, forKey: "ticket_status")
        }
        
    }
    
}
