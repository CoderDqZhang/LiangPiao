//
//	ShowSessionModel.swift
//
//	Create by Zhang on 22/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ShowSessionModel : NSObject, NSCoding{
    
    var endTime : String!
    var id : Int64!
    var minDiscount : String!
    var minPrice : Int!
    var name : String!
    var openRegions : String!
    var otherRegions : String!
    var startTime : String!
    var ticketCount : Int!
    var ticketList : [TicketList]!
    var ticketStatus : Int!
    var venueMap: String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        endTime = dictionary["end_time"] as? String
        id = dictionary["id"] as? Int64
        minDiscount = dictionary["min_discount"] as? String
        minPrice = dictionary["min_price"] as? Int
        name = dictionary["name"] as? String
        openRegions = dictionary["open_regions"] as? String
        otherRegions = dictionary["other_regions"] as? String
        startTime = dictionary["start_time"] as? String
        ticketCount = dictionary["ticket_count"] as? Int
        ticketList = [TicketList]()
        if let ticketListArray = dictionary["ticket_list"] as? [NSDictionary]{
            for dic in ticketListArray{
                let value = TicketList(fromDictionary: dic)
                ticketList.append(value)
            }
        }
        ticketStatus = dictionary["ticket_status"] as? Int
        venueMap = dictionary["venue_map"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if endTime != nil{
            dictionary["end_time"] = endTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if minDiscount != nil{
            dictionary["min_discount"] = minDiscount
        }
        if minPrice != nil{
            dictionary["min_price"] = minPrice
        }
        if name != nil{
            dictionary["name"] = name
        }
        if openRegions != nil{
            dictionary["open_regions"] = openRegions
        }
        if otherRegions != nil{
            dictionary["other_regions"] = otherRegions
        }
        if startTime != nil{
            dictionary["start_time"] = startTime
        }
        if ticketCount != nil{
            dictionary["ticket_count"] = ticketCount
        }
        if ticketList != nil{
            var dictionaryElements = [NSDictionary]()
            for ticketListElement in ticketList {
                dictionaryElements.append(ticketListElement.toDictionary())
            }
            dictionary["ticket_list"] = dictionaryElements
        }
        if ticketStatus != nil{
            dictionary["ticket_status"] = ticketStatus
        }
        if venueMap != nil{
            dictionary["venue_map"] = venueMap
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        endTime = aDecoder.decodeObject(forKey: "end_time") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int64
        minDiscount = aDecoder.decodeObject(forKey: "min_discount") as? String
        minPrice = aDecoder.decodeObject(forKey: "min_price") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        openRegions = aDecoder.decodeObject(forKey: "open_regions") as? String
        otherRegions = aDecoder.decodeObject(forKey: "other_regions") as? String
        startTime = aDecoder.decodeObject(forKey: "start_time") as? String
        ticketCount = aDecoder.decodeObject(forKey: "ticket_count") as? Int
        ticketList = aDecoder.decodeObject(forKey: "ticket_list") as? [TicketList]
        ticketStatus = aDecoder.decodeObject(forKey: "ticket_status") as? Int
        venueMap = aDecoder.decodeObject(forKey: "venue_map") as? String

        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if endTime != nil{
            aCoder.encode(endTime, forKey: "end_time")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if minDiscount != nil{
            aCoder.encode(minDiscount, forKey: "min_discount")
        }
        if minPrice != nil{
            aCoder.encode(minPrice, forKey: "min_price")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if openRegions != nil{
            aCoder.encode(openRegions, forKey: "open_regions")
        }
        if otherRegions != nil{
            aCoder.encode(otherRegions, forKey: "other_regions")
        }
        if startTime != nil{
            aCoder.encode(startTime, forKey: "start_time")
        }
        if ticketCount != nil{
            aCoder.encode(ticketCount, forKey: "ticket_count")
        }
        if ticketList != nil{
            aCoder.encode(ticketList, forKey: "ticket_list")
        }
        if ticketStatus != nil{
            aCoder.encode(ticketStatus, forKey: "ticket_status")
        }
        if venueMap != nil{
            aCoder.encode(venueMap, forKey: "venue_map")
        }
        
    }
    
}

let kEncodeObjectPath_Search_History = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last)! + "/\(SearchHistoryDataPath)"

class SearchHistory : NSObject, NSCoding{

    var sellSearchHistory : [String] = []
    var showSearchHistory : [String] = []
    
    
    fileprivate override init() {
        
    }
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    static let shareInstance = SearchHistory()
    
    init(fromDictionary dictionary: NSDictionary){
        sellSearchHistory = (dictionary["sellSearchHistory"] as? [String])!
        showSearchHistory = (dictionary["showSearchHistory"] as? [String])!
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        dictionary["sellSearchHistory"] = sellSearchHistory

        dictionary["showSearchHistory"] = showSearchHistory

        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        sellSearchHistory = (aDecoder.decodeObject(forKey: "sellSearchHistory") as? [String])!
        showSearchHistory = (aDecoder.decodeObject(forKey: "showSearchHistory") as? [String])!
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        aCoder.encode(sellSearchHistory, forKey: "sellSearchHistory")
        aCoder.encode(showSearchHistory, forKey: "showSearchHistory")        
    }
    
    //保存数据
    func saveData(searchHistory:SearchHistory) {
        NSKeyedArchiver.archiveRootObject(searchHistory, toFile: kEncodeObjectPath_Search_History)
    }
    
    //读取数据
    func loadData() -> SearchHistory{
        if !FileManager.default.fileExists(atPath: kEncodeObjectPath_Search_History) {
            FileManager.default.createFile(atPath: kEncodeObjectPath_Search_History, contents: nil, attributes: nil)
            SearchHistory.shareInstance.sellSearchHistory = []
            SearchHistory.shareInstance.showSearchHistory = []
            SearchHistory.shareInstance.saveData(searchHistory: SearchHistory.shareInstance)
            return SearchHistory.shareInstance
        }
        let shareInstance =  NSKeyedUnarchiver.unarchiveObject(withFile: kEncodeObjectPath_Search_History) as! SearchHistory
        return shareInstance
    }
}
