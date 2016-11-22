//
//	RecommentTickes.swift
//
//	Create by Zhang on 22/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RecommentTickes : NSObject, NSCoding{
    
    var hasNext : Bool!
    var nextStart : Int!
    var showList : [HomeTicketModel]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        hasNext = dictionary["has_next"] as? Bool
        nextStart = dictionary["next_start"] as? Int
        showList = [HomeTicketModel]()
        if let showListArray = dictionary["show_list"] as? [NSDictionary]{
            for dic in showListArray{
                let value = HomeTicketModel(fromDictionary: dic)
                showList.append(value)
            }
        }
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
        if nextStart != nil{
            dictionary["next_start"] = nextStart
        }
        if showList != nil{
            var dictionaryElements = [NSDictionary]()
            for showListElement in showList {
                dictionaryElements.append(showListElement.toDictionary())
            }
            dictionary["show_list"] = dictionaryElements
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
        nextStart = aDecoder.decodeObjectForKey("next_start") as? Int
        showList = aDecoder.decodeObjectForKey("show_list") as? [HomeTicketModel]
        
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
        if nextStart != nil{
            aCoder.encodeObject(nextStart, forKey: "next_start")
        }
        if showList != nil{
            aCoder.encodeObject(showList, forKey: "show_list")
        }
        
    }
    
}
