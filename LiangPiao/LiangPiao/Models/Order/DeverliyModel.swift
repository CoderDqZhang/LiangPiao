//
//  DeverliyModel.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import Foundation


class DeverliyModel : NSObject, NSCoding{
    
    var eBusinessID : String!
    var logisticCode : String!
    var shipperCode : String!
    var state : String!
    var success : Bool!
    var traces : [Trace]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        eBusinessID = dictionary["EBusinessID"] as? String
        logisticCode = dictionary["LogisticCode"] as? String
        shipperCode = dictionary["ShipperCode"] as? String
        state = dictionary["State"] as? String
        success = dictionary["Success"] as? Bool
        traces = [Trace]()
        if let tracesArray = dictionary["Traces"] as? [NSDictionary]{
            for dic in tracesArray{
                let value = Trace(fromDictionary: dic)
                traces.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if eBusinessID != nil{
            dictionary["EBusinessID"] = eBusinessID
        }
        if logisticCode != nil{
            dictionary["LogisticCode"] = logisticCode
        }
        if shipperCode != nil{
            dictionary["ShipperCode"] = shipperCode
        }
        if state != nil{
            dictionary["State"] = state
        }
        if success != nil{
            dictionary["Success"] = success
        }
        if traces != nil{
            var dictionaryElements = [NSDictionary]()
            for tracesElement in traces {
                dictionaryElements.append(tracesElement.toDictionary())
            }
            dictionary["Traces"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        eBusinessID = aDecoder.decodeObject(forKey: "EBusinessID") as? String
        logisticCode = aDecoder.decodeObject(forKey: "LogisticCode") as? String
        shipperCode = aDecoder.decodeObject(forKey: "ShipperCode") as? String
        state = aDecoder.decodeObject(forKey: "State") as? String
        success = aDecoder.decodeObject(forKey: "Success") as? Bool
        traces = aDecoder.decodeObject(forKey: "Traces") as? [Trace]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if eBusinessID != nil{
            aCoder.encode(eBusinessID, forKey: "EBusinessID")
        }
        if logisticCode != nil{
            aCoder.encode(logisticCode, forKey: "LogisticCode")
        }
        if shipperCode != nil{
            aCoder.encode(shipperCode, forKey: "ShipperCode")
        }
        if state != nil{
            aCoder.encode(state, forKey: "State")
        }
        if success != nil{
            aCoder.encode(success, forKey: "Success")
        }
        if traces != nil{
            aCoder.encode(traces, forKey: "Traces")
        }
        
    }
    
}

class Trace : NSObject, NSCoding{
    
    var acceptStation : String!
    var acceptTime : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        acceptStation = dictionary["AcceptStation"] as? String
        acceptTime = dictionary["AcceptTime"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if acceptStation != nil{
            dictionary["AcceptStation"] = acceptStation
        }
        if acceptTime != nil{
            dictionary["AcceptTime"] = acceptTime
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        acceptStation = aDecoder.decodeObject(forKey: "AcceptStation") as? String
        acceptTime = aDecoder.decodeObject(forKey: "AcceptTime") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if acceptStation != nil{
            aCoder.encode(acceptStation, forKey: "AcceptStation")
        }
        if acceptTime != nil{
            aCoder.encode(acceptTime, forKey: "AcceptTime")
        }
        
    }
    
}
