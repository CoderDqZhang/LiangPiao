//
//	TicketCategorys.swift
//
//	Create by Zhang on 22/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class TicketCategorys : NSObject, NSCoding{
    
    var id : intmax_t!
    var name : String!
    var showCount : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? intmax_t
        name = dictionary["name"] as? String
        showCount = dictionary["show_count"] as? Int
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
        if showCount != nil{
            dictionary["show_count"] = showCount
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObjectForKey("id") as? intmax_t
        name = aDecoder.decodeObjectForKey("name") as? String
        showCount = aDecoder.decodeObjectForKey("show_count") as? Int
        
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
        if showCount != nil{
            aCoder.encodeObject(showCount, forKey: "show_count")
        }
        
    }
    
}
