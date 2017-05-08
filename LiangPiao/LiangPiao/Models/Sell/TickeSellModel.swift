//
//  TickeSellModel.swift
//  LiangPiao
//
//  Created by Zhang on 20/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TickeSellModel : NSObject, NSCoding{

    var balance : Int!
    var deliveryTypeChoices : [[String]]!
    var regionChoices : [[String]]!
    var needDeposit : Bool!
    var row : [Int]!
    var seatTypeChoices : [[String]]!
    var sellCategoryChoices : [[String]]!
    var sellTypeChoices : [[String]]!
    var ticketChoices : [[String]]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        balance = dictionary["balance"] as? Int
        deliveryTypeChoices = dictionary["delivery_type_choices"] as? [[String]]
        needDeposit = dictionary["need_deposit"] as? Bool
        regionChoices = dictionary["region_choices"] as? [[String]]
        row = dictionary["row"] as? [Int]
        sellCategoryChoices = dictionary["sell_category_choices"] as? [[String]]
        seatTypeChoices = dictionary["seat_type_choices"] as? [[String]]
        sellTypeChoices = dictionary["sell_type_choices"] as? [[String]]
        ticketChoices = dictionary["ticket_choices"] as? [[String]]
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
        if deliveryTypeChoices != nil{
            dictionary["delivery_type_choices"] = deliveryTypeChoices
        }
        if needDeposit != nil{
            dictionary["need_deposit"] = needDeposit
        }
        if regionChoices != nil{
            dictionary["region_choices"] = regionChoices
        }
        if row != nil{
            dictionary["row"] = row
        }
        if seatTypeChoices != nil{
            dictionary["seat_type_choices"] = seatTypeChoices
        }
        if sellCategoryChoices != nil{
            dictionary["sell_category_choices"] = sellCategoryChoices
        }
        if sellTypeChoices != nil{
            dictionary["sell_type_choices"] = sellTypeChoices
        }
        if ticketChoices != nil{
            dictionary["ticket_choices"] = ticketChoices
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        balance = aDecoder.decodeObject(forKey: "balance") as? Int
        deliveryTypeChoices = aDecoder.decodeObject(forKey: "delivery_type_choices") as? [[String]]
        needDeposit = aDecoder.decodeObject(forKey: "need_deposit") as? Bool
        regionChoices = aDecoder.decodeObject(forKey: "region_choices") as? [[String]]
        row = aDecoder.decodeObject(forKey: "row") as? [Int]
        seatTypeChoices = aDecoder.decodeObject(forKey: "seat_type_choices") as? [[String]]
        sellCategoryChoices = aDecoder.decodeObject(forKey: "sell_category_choices") as? [[String]]
        sellTypeChoices = aDecoder.decodeObject(forKey: "sell_type_choices") as? [[String]]
        ticketChoices = aDecoder.decodeObject(forKey: "ticket_choices") as? [[String]]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if balance != nil{
            aCoder.encode(balance, forKey: "balance")
        }
        if deliveryTypeChoices != nil{
            aCoder.encode(deliveryTypeChoices, forKey: "delivery_type_choices")
        }
        if needDeposit != nil{
            aCoder.encode(needDeposit, forKey: "need_deposit")
        }
        if regionChoices != nil{
            aCoder.encode(regionChoices, forKey: "region_choices")
        }
        if row != nil{
            aCoder.encode(row, forKey: "row")
        }
        if seatTypeChoices != nil{
            aCoder.encode(seatTypeChoices, forKey: "seat_type_choices")
        }
        if sellCategoryChoices != nil{
            aCoder.encode(sellCategoryChoices, forKey: "sell_category_choices")
        }
        if sellTypeChoices != nil{
            aCoder.encode(sellTypeChoices, forKey: "sell_type_choices")
        }
        if ticketChoices != nil{
            aCoder.encode(ticketChoices, forKey: "ticket_choices")
        }
        
    }
}
