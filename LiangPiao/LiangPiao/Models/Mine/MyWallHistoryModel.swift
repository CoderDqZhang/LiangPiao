//
//  MyWallHistoryModel.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyWallHistoryModel : NSObject, NSCoding{
    
    var hasNext : Bool!
    var hisList : [HisList]!
    var nextPage : Int!
    var total : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        hasNext = dictionary["has_next"] as? Bool
        hisList = [HisList]()
        if let hisListArray = dictionary["his_list"] as? [NSDictionary]{
            for dic in hisListArray{
                let value = HisList(fromDictionary: dic)
                hisList.append(value)
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
        if hisList != nil{
            var dictionaryElements = [NSDictionary]()
            for hisListElement in hisList {
                dictionaryElements.append(hisListElement.toDictionary())
            }
            dictionary["his_list"] = dictionaryElements
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
        hasNext = aDecoder.decodeObjectForKey("has_next") as? Bool
        hisList = aDecoder.decodeObjectForKey("his_list") as? [HisList]
        nextPage = aDecoder.decodeObjectForKey("next_page") as? Int
        total = aDecoder.decodeObjectForKey("total") as? Int
        
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
        if hisList != nil{
            aCoder.encodeObject(hisList, forKey: "his_list")
        }
        if nextPage != nil{
            aCoder.encodeObject(nextPage, forKey: "next_page")
        }
        if total != nil{
            aCoder.encodeObject(total, forKey: "total")
        }
        
    }
    
}
class HisList : NSObject, NSCoding{
    
    var amount : Int!
    var balance : Int!
    var created : String!
    var desc : String!
    var optionDesc : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        amount = dictionary["amount"] as? Int
        balance = dictionary["balance"] as? Int
        created = dictionary["created"] as? String
        desc = dictionary["desc"] as? String
        optionDesc = dictionary["option_desc"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if amount != nil{
            dictionary["amount"] = amount
        }
        if balance != nil{
            dictionary["balance"] = balance
        }
        if created != nil{
            dictionary["created"] = created
        }
        if desc != nil{
            dictionary["desc"] = desc
        }
        if optionDesc != nil{
            dictionary["option_desc"] = optionDesc
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        amount = aDecoder.decodeObjectForKey("amount") as? Int
        balance = aDecoder.decodeObjectForKey("balance") as? Int
        created = aDecoder.decodeObjectForKey("created") as? String
        desc = aDecoder.decodeObjectForKey("desc") as? String
        optionDesc = aDecoder.decodeObjectForKey("option_desc") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if amount != nil{
            aCoder.encodeObject(amount, forKey: "amount")
        }
        if balance != nil{
            aCoder.encodeObject(balance, forKey: "balance")
        }
        if created != nil{
            aCoder.encodeObject(created, forKey: "created")
        }
        if desc != nil{
            aCoder.encodeObject(desc, forKey: "desc")
        }
        if optionDesc != nil{
            aCoder.encodeObject(optionDesc, forKey: "option_desc")
        }
        
    }
    
}
