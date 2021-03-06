//
//  FavorityModel.swift
//  LiangPiao
//
//  Created by Zhang on 01/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class  FavorityModel : NSObject, NSCoding{
    
    var hasNext : Bool!
    var items : [Item]!
    var nextPage : Int!
    var total : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        hasNext = dictionary["has_next"] as? Bool
        items = [Item]()
        if let itemsArray = dictionary["items"] as? [NSDictionary]{
            for dic in itemsArray{
                let value = Item(fromDictionary: dic)
                items.append(value)
            }
        }
        nextPage = dictionary["next_page"] as? Int
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
        if items != nil{
            var dictionaryElements = [NSDictionary]()
            for itemsElement in items {
                dictionaryElements.append(itemsElement.toDictionary())
            }
            dictionary["items"] = dictionaryElements
        }
        if nextPage != nil{
            dictionary["next_page"] = nextPage
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
        items = aDecoder.decodeObject(forKey: "items") as? [Item]
        nextPage = aDecoder.decodeObject(forKey: "next_page") as? Int
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
        if items != nil{
            aCoder.encode(items, forKey: "items")
        }
        if nextPage != nil{
            aCoder.encode(nextPage, forKey: "next_page")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        
    }
    
}

class Item : NSObject, NSCoding{
    
    var created : String!
    var id : Int!
    var show : TicketShowModel!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        created = dictionary["created"] as? String
        id = dictionary["id"] as? Int
        if let showData = dictionary["show"] as? NSDictionary{
            show = TicketShowModel(fromDictionary: showData)
        }
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
        if id != nil{
            dictionary["id"] = id
        }
        if show != nil{
            dictionary["show"] = show.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        created = aDecoder.decodeObject(forKey: "created") as? String
        id = aDecoder.decodeObject(forKey: "id")as? Int
        show = aDecoder.decodeObject(forKey: "show") as? TicketShowModel
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if created != nil{
            aCoder.encode(created, forKey: "created")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if show != nil{
            aCoder.encode(show, forKey: "show")
        }
        
    }
    
}
