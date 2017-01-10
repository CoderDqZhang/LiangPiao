//
//  HomeCenterModel.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class HomeCenterModel: NSObject {
    var image:UIImage!
    var title:String?
}

class Banners : NSObject, NSCoding{
    
    var banners : [Banner]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        banners = [Banner]()
        if let bannersArray = dictionary["banners"] as? [NSDictionary]{
            for dic in bannersArray{
                let value = Banner(fromDictionary: dic)
                banners.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if banners != nil{
            var dictionaryElements = [NSDictionary]()
            for bannersElement in banners {
                dictionaryElements.append(bannersElement.toDictionary())
            }
            dictionary["banners"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        banners = aDecoder.decodeObjectForKey("banners") as? [Banner]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if banners != nil{
            aCoder.encodeObject(banners, forKey: "banners")
        }
        
    }
    
}

class Banner : NSObject, NSCoding{
    
    var bannerType : Int!
    var id : Int!
    var image : String!
    var sessionId : Int!
    var showId : Int!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        bannerType = dictionary["banner_type"] as? Int
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        sessionId = dictionary["session_id"] as? Int
        showId = dictionary["show_id"] as? Int
        url = dictionary["url"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if bannerType != nil{
            dictionary["banner_type"] = bannerType
        }
        if id != nil{
            dictionary["id"] = id
        }
        if image != nil{
            dictionary["image"] = image
        }
        if sessionId != nil{
            dictionary["session_id"] = sessionId
        }
        if showId != nil{
            dictionary["show_id"] = showId
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bannerType = aDecoder.decodeObjectForKey("banner_type") as? Int
        id = aDecoder.decodeObjectForKey("id") as? Int
        image = aDecoder.decodeObjectForKey("image") as? String
        sessionId = aDecoder.decodeObjectForKey("session_id") as? Int
        showId = aDecoder.decodeObjectForKey("show_id") as? Int
        url = aDecoder.decodeObjectForKey("url") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if bannerType != nil{
            aCoder.encodeObject(bannerType, forKey: "banner_type")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if image != nil{
            aCoder.encodeObject(image, forKey: "image")
        }
        if sessionId != nil{
            aCoder.encodeObject(sessionId, forKey: "session_id")
        }
        if showId != nil{
            aCoder.encodeObject(showId, forKey: "show_id")
        }
        if url != nil{
            aCoder.encodeObject(url, forKey: "url")
        }
        
    }
    
}
