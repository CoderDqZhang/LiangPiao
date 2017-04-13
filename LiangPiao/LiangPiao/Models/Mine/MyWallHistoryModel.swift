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
        hasNext = aDecoder.decodeObject(forKey: "has_next") as? Bool
        hisList = aDecoder.decodeObject(forKey: "his_list") as? [HisList]
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
        if hisList != nil{
            aCoder.encode(hisList, forKey: "his_list")
        }
        if nextPage != nil{
            aCoder.encode(nextPage, forKey: "next_page")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
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
        amount = aDecoder.decodeObject(forKey: "amount") as? Int
        balance = aDecoder.decodeObject(forKey: "balance") as? Int
        created = aDecoder.decodeObject(forKey: "created") as? String
        desc = aDecoder.decodeObject(forKey: "desc") as? String
        optionDesc = aDecoder.decodeObject(forKey: "option_desc") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if amount != nil{
            aCoder.encode(amount, forKey: "amount")
        }
        if balance != nil{
            aCoder.encode(balance, forKey: "balance")
        }
        if created != nil{
            aCoder.encode(created, forKey: "created")
        }
        if desc != nil{
            aCoder.encode(desc, forKey: "desc")
        }
        if optionDesc != nil{
            aCoder.encode(optionDesc, forKey: "option_desc")
        }
        
    }
    
}
