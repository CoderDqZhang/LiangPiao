//
//  NotificationService.swift
//  LiangPiaoPush
//
//  Created by Zhang on 02/01/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UserNotifications
import UIKit

typealias completionHandler = (attach:UNNotificationAttachment) -> Void

let kEncodeUserCachesDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first! as String


class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceiveNotificationRequest(request: UNNotificationRequest, withContentHandler contentHandler: (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
    
        let dict = self.bestAttemptContent?.userInfo
        let notiDict = dict!["aps"] as! NSDictionary
        let imageUrl = "\((dict!["imageAbsoluteString"])!)"
        let dic = notiDict["alert"]! as! NSDictionary
        self.bestAttemptContent!.title = "\((dic["title"])!)"
        self.bestAttemptContent!.subtitle = "\((dic["subtitle"])!)"
        self.bestAttemptContent!.body = "\((dic["body"])!)"
        print(imageUrl)
        self.loadAttachmentForUrlString(imageUrl, type: "image") { (attach) in
            self.bestAttemptContent!.attachments = [attach]
            self.contentHandler!(self.bestAttemptContent!);
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    func loadAttachmentForUrlString(urlStr:String, type:String, completionHandle:completionHandler) {
        let url = NSURL.init(string: urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)

        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.init(configuration: config)
        let fileExt = self.fileExtensionForMediaType(type)
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                let path = self.getCachesDirectoryUserInfoDocumetPathDocument("Public", document: "PushImages")
                let saveName = path?.stringByAppendingString("/pushImage\(fileExt)")
                let image = UIImage.init(data: data!)
                do {
                    try  UIImageJPEGRepresentation(image!, 1)?.writeToFile(saveName!, options: .AtomicWrite)
                    var attachment:UNNotificationAttachment
                    try  attachment = UNNotificationAttachment.init(identifier: "remote-atta1", URL: NSURL.init(fileURLWithPath: saveName!), options: nil)
                    completionHandle(attach: attachment)
                }catch{
                    
                }
            }
        }
        task.resume()
    }
    
    func getCachesDirectoryUserInfoDocumetPathDocument(user:String, document:String) ->String? {
        let manager = NSFileManager.defaultManager()
        let path = kEncodeUserCachesDirectory.stringByAppendingString("/\(user)").stringByAppendingString("/\(document)")
        if !manager.fileExistsAtPath(path) {
            do {
                try manager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
                return path
            } catch {
                print("创建失败")
                return nil
            }
        }else{
            return path
        }
    }
    
    func fileExtensionForMediaType(type:String) -> String{
        var ext = type
        if type == "image" {
            ext = "jpg"
        }
        
        if type == "video" {
            ext = "mp4"
        }
        
        if type == "audio" {
            ext = "mp3"
        }
        return ".\(ext)"
    }
}


