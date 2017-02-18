//
//	AddressModel.swift
//
//	Create by Zhang on 23/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

let kEncodeObjectPath_User_Address = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last?.stringByAppendingString("/UserAddress")

class AddressModel : NSObject, NSCoding{
    
    var address : String!
    var defaultField : Bool!
    var id : intmax_t!
    var location : String!
    var mobileNum : String!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        address = dictionary["address"] as? String
        defaultField = dictionary["default"] as? Bool
        id = dictionary["id"] as? intmax_t
        location = dictionary["location"] as? String
        mobileNum = dictionary["mobile_num"] as? String
        name = dictionary["name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if address != nil{
            dictionary["address"] = address
        }
        if defaultField != nil{
            dictionary["default"] = defaultField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if location != nil{
            dictionary["location"] = location
        }
        if mobileNum != nil{
            dictionary["mobile_num"] = mobileNum
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObjectForKey("address") as? String
        defaultField = aDecoder.decodeObjectForKey("default") as? Bool
        id = aDecoder.decodeObjectForKey("id") as? intmax_t
        location = aDecoder.decodeObjectForKey("location") as? String
        mobileNum = aDecoder.decodeObjectForKey("mobile_num") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encodeObject(address, forKey: "address")
        }
        if defaultField != nil{
            aCoder.encodeObject(defaultField, forKey: "default")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if location != nil{
            aCoder.encodeObject(location, forKey: "location")
        }
        if mobileNum != nil{
            aCoder.encodeObject(mobileNum, forKey: "mobile_num")
        }
        if name != nil{
            aCoder.encodeObject(name, forKey: "name")
        }
        
    }
    
    class func removeAddress(){
        let fileManager = NSFileManager.defaultManager()
        do{
            try fileManager.removeItemAtPath(kEncodeObjectPath_User_Address!)
        }catch {
            
        }
    }
    
    class func haveAddress() -> Bool {
        let fileManager = NSFileManager.defaultManager()
        return fileManager.fileExistsAtPath(kEncodeObjectPath_User_Address!)
    }
    
    class func unarchiveObjectWithFile() -> [AddressModel] {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(kEncodeObjectPath_User_Address!)! as! [AddressModel]
    }
    
    class func archiveRootObject(models:[AddressModel]){
        NSKeyedArchiver.archiveRootObject(models, toFile: kEncodeObjectPath_User_Address!)
    }
    
}
