//
//  ZDQFMDBHelp.swift
//  LiangPiao
//
//  Created by Zhang on 15/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class ZDQFMDBHelp: NSObject {
    
    
    
    static let shareInstand = ZDQFMDBHelp()

    var dbQueue:FMDatabaseQueue!
    private override init() {
        
    }
    
    func dbPathWithDirectoryName(directoryName:String?) ->String{
        // 示例
        var documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let manager = NSFileManager.defaultManager()
        if directoryName == nil || directoryName!.length == 0 {
            documentsFolder = documentsFolder.stringByAppendingString("/LiangPiao")
        }else{
            documentsFolder = documentsFolder.stringByAppendingString("/\(directoryName!)")

        }
        
        let exit = manager.fileExistsAtPath(documentsFolder, isDirectory: nil)
        if !exit {
            do {
                try  manager.createDirectoryAtPath(directoryName!, withIntermediateDirectories: true, attributes: nil)

            } catch  {
                print("创建文件夹失败")
            }
        }
        let path = documentsFolder.stringByAppendingString("/LiangPiao.sqlite")

        return path
    }
    
    func dbPath() -> String{
        return self.dbPathWithDirectoryName(nil)
    }
        
    
    func getdbQueue() -> FMDatabaseQueue{
        if self.dbQueue == nil {
            self.dbQueue = FMDatabaseQueue.init(path: self.dbPath())
        }
        return self.dbQueue;
    }
}
