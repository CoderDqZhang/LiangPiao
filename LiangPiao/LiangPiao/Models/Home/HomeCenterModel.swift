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

//
//	Banner.swift
//
//	Create by Zhang on 10/1/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Banner : NSObject, NSCoding{
    
    var bannerType : Int!
    var id : intmax_t!
    var image : String!
    var show : TicketShowModel!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        bannerType = dictionary["banner_type"] as? Int
        id = dictionary["id"] as? intmax_t
        image = dictionary["image"] as? String
        if let showData = dictionary["show"] as? NSDictionary{
            show = TicketShowModel(fromDictionary: showData)
        }
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
        if show != nil{
            dictionary["show"] = show.toDictionary()
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
        id = aDecoder.decodeObjectForKey("id") as? intmax_t
        image = aDecoder.decodeObjectForKey("image") as? String
        show = aDecoder.decodeObjectForKey("show") as? TicketShowModel
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
        if show != nil{
            aCoder.encodeObject(show, forKey: "show")
        }
        if url != nil{
            aCoder.encodeObject(url, forKey: "url")
        }
        
    }
    
}
