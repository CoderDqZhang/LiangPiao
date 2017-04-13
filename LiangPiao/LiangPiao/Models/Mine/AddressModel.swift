//
//	AddressModel.swift
//
//	Create by Zhang on 23/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

let kEncodeObjectPath_User_Address = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last)! + "/UserAddress"

class AddressModel : NSObject, NSCoding{
    
    var address : String!
    var defaultField : Bool!
    var id : Int64!
    var location : String!
    var mobileNum : String!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        address = dictionary["address"] as? String
        defaultField = dictionary["default"] as? Bool
        id = dictionary["id"] as? Int64
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
        address = aDecoder.decodeObject(forKey: "address") as? String
        defaultField = aDecoder.decodeObject(forKey: "default") as? Bool
        id = aDecoder.decodeObject(forKey: "id")as? Int64
        location = aDecoder.decodeObject(forKey: "location") as? String
        mobileNum = aDecoder.decodeObject(forKey: "mobile_num") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if defaultField != nil{
            aCoder.encode(defaultField, forKey: "default")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if mobileNum != nil{
            aCoder.encode(mobileNum, forKey: "mobile_num")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        
    }
    
    class func removeAddress(){
        let fileManager = FileManager.default
        do{
            try fileManager.removeItem(atPath: kEncodeObjectPath_User_Address)
        }catch {
            
        }
    }
    
    class func haveAddress() -> Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: kEncodeObjectPath_User_Address)
    }
    
    class func unarchiveObjectWithFile() -> [AddressModel] {
        return NSKeyedUnarchiver.unarchiveObject(withFile: kEncodeObjectPath_User_Address)! as! [AddressModel]
    }
    
    class func archiveRootObject(_ models:[AddressModel]){
        NSKeyedArchiver.archiveRootObject(models, toFile: kEncodeObjectPath_User_Address)
    }
    
}
