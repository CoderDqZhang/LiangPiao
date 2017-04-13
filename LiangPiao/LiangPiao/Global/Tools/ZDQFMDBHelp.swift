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
    fileprivate override init() {
        
    }
    
    func dbPathWithDirectoryName(_ directoryName:String?) ->String{
        // 示例
        var documentsFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let manager = FileManager.default
        if directoryName == nil || directoryName!.length == 0 {
            documentsFolder = documentsFolder + "/LiangPiao"
        }else{
            documentsFolder = documentsFolder + "/\(directoryName!)"

        }
        
        let exit = manager.fileExists(atPath: documentsFolder, isDirectory: nil)
        if !exit {
            do {
                try  manager.createDirectory(atPath: directoryName!, withIntermediateDirectories: true, attributes: nil)

            } catch  {
                print("创建文件夹失败")
            }
        }
        let path = documentsFolder + "/LiangPiao.sqlite"

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
