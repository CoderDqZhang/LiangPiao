//
//  TickeSellModel.swift
//  LiangPiao
//
//  Created by Zhang on 20/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TickeSellModel : NSObject, NSCoding{
    
    var deliveryTypeChoices : [[String]]!
    var regionChoices : [[String]]!
    var row : [Int]!
    var seatTypeChoices : [[String]]!
    var sellCategoryChoices : [[String]]!
    var sellTypeChoices : [[String]]!
    var ticketChoices : [[String]]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        deliveryTypeChoices = dictionary["delivery_type_choices"] as? [[String]]
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
        if deliveryTypeChoices != nil{
            dictionary["delivery_type_choices"] = deliveryTypeChoices
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
        deliveryTypeChoices = aDecoder.decodeObjectForKey("delivery_type_choices") as? [[String]]
        regionChoices = aDecoder.decodeObjectForKey("region_choices") as? [[String]]
        row = aDecoder.decodeObjectForKey("row") as? [Int]
        seatTypeChoices = aDecoder.decodeObjectForKey("seat_type_choices") as? [[String]]
        sellCategoryChoices = aDecoder.decodeObjectForKey("sell_category_choices") as? [[String]]
        sellTypeChoices = aDecoder.decodeObjectForKey("sell_type_choices") as? [[String]]
        ticketChoices = aDecoder.decodeObjectForKey("ticket_choices") as? [[String]]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if deliveryTypeChoices != nil{
            aCoder.encodeObject(deliveryTypeChoices, forKey: "delivery_type_choices")
        }
        if regionChoices != nil{
            aCoder.encodeObject(regionChoices, forKey: "region_choices")
        }
        if row != nil{
            aCoder.encodeObject(row, forKey: "row")
        }
        if seatTypeChoices != nil{
            aCoder.encodeObject(seatTypeChoices, forKey: "seat_type_choices")
        }
        if sellCategoryChoices != nil{
            aCoder.encodeObject(sellCategoryChoices, forKey: "sell_category_choices")
        }
        if sellTypeChoices != nil{
            aCoder.encodeObject(sellTypeChoices, forKey: "sell_type_choices")
        }
        if ticketChoices != nil{
            aCoder.encodeObject(ticketChoices, forKey: "ticket_choices")
        }
        
    }
}
