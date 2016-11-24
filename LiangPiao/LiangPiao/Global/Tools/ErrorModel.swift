//
//	ErrorModel.swift
//
//	Create by Zhang on 24/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ErrorModel : NSObject, NSCoding{
    
    var code : Int!
    var errors : [Error]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        code = dictionary["code"] as? Int
        errors = [Error]()
        if let errorsArray = dictionary["errors"] as? [NSDictionary]{
            for dic in errorsArray{
                let value = Error(fromDictionary: dic)
                errors.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if code != nil{
            dictionary["code"] = code
        }
        if errors != nil{
            var dictionaryElements = [NSDictionary]()
            for errorsElement in errors {
                dictionaryElements.append(errorsElement.toDictionary())
            }
            dictionary["errors"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        code = aDecoder.decodeObjectForKey("code") as? Int
        errors = aDecoder.decodeObjectForKey("errors") as? [Error]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if code != nil{
            aCoder.encodeObject(code, forKey: "code")
        }
        if errors != nil{
            aCoder.encodeObject(errors, forKey: "errors")
        }
        
    }
    
}

class Error : NSObject, NSCoding{
    
    var error : [String]!
    var type : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        error = dictionary["error"] as? [String]
        type = dictionary["type"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if error != nil{
            dictionary["error"] = error
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        error = aDecoder.decodeObjectForKey("error") as? [String]
        type = aDecoder.decodeObjectForKey("type") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if error != nil{
            aCoder.encodeObject(error, forKey: "error")
        }
        if type != nil{
            aCoder.encodeObject(type, forKey: "type")
        }
        
    }
    
}
