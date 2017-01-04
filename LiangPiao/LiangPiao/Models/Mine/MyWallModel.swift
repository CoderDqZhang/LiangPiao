//
//  MyWallModel.swift
//  LiangPiao
//
//  Created by Zhang on 12/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyWallModel : NSObject, NSCoding{
    
    var balance : Int!
    var deposit : Int!
    var pendingBalance : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        balance = dictionary["balance"] as? Int
        deposit = dictionary["deposit"] as? Int
        pendingBalance = dictionary["pending_balance"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if balance != nil{
            dictionary["balance"] = balance
        }
        if deposit != nil{
            dictionary["deposit"] = deposit
        }
        if pendingBalance != nil{
            dictionary["pending_balance"] = pendingBalance
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        balance = aDecoder.decodeObjectForKey("balance") as? Int
        deposit = aDecoder.decodeObjectForKey("deposit") as? Int
        pendingBalance = aDecoder.decodeObjectForKey("pending_balance") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if balance != nil{
            aCoder.encodeObject(balance, forKey: "balance")
        }
        if deposit != nil{
            aCoder.encodeObject(deposit, forKey: "deposit")
        }
        if pendingBalance != nil{
            aCoder.encodeObject(pendingBalance, forKey: "pending_balance")
        }
        
    }
    
}
