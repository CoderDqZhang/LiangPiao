//
//  NotificationService.swift
//  LiangPiaoPush
//
//  Created by Zhang on 02/01/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UserNotifications
import UIKit

typealias completionHandler = (_ attach:UNNotificationAttachment) -> Void

let kEncodeUserCachesDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String


@available(iOSApplicationExtension 10.0, *)
class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
    
        let dict = self.bestAttemptContent?.userInfo
        let notiDict = dict!["aps"] as! NSDictionary
        
        self.bestAttemptContent!.title = "\((dict!["title"])!)"
        self.bestAttemptContent!.body = "\((notiDict["alert"])!)"
        if dict!["type"] as! String != "operation" {
            let imageUrl = "\((dict!["imageAbsoluteString"])!)"
            self.loadAttachmentForUrlString(urlStr: imageUrl, type: "image") { (attach) in
                self.bestAttemptContent!.attachments = [attach]
                self.contentHandler!(self.bestAttemptContent!);
            }
        }else{
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
    
    func loadAttachmentForUrlString(urlStr:String, type:String, completionHandle:@escaping completionHandler) {
        let url = NSURL.init(string: urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let fileExt = self.fileExtensionForMediaType(type: type)
        let task = session.dataTask(with: url! as URL) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                let path = self.getCachesDirectoryUserInfoDocumetPathDocument(user: "Public", document: "PushImages")
                let saveName = path?.appending("/pushImage\(fileExt)")
                let image = UIImage.init(data: data!)
                do {
                    try UIImageJPEGRepresentation(image!, 1.0)?.write(to: NSURL.init(string: saveName!) as! URL, options: Data.WritingOptions.atomicWrite)
                    var attachment:UNNotificationAttachment
                    try  attachment = UNNotificationAttachment(identifier: "remote-atta1", url: NSURL.init(fileURLWithPath: saveName!) as URL, options: nil)
                    completionHandle(attachment)
                }catch{
                    
                }
            }
        }
        task.resume()
    }
    
    func getCachesDirectoryUserInfoDocumetPathDocument(user:String, document:String) ->String? {
        let manager = FileManager.default
        let path = kEncodeUserCachesDirectory.appending("/\(user)").appending("/\(document)")
//            kEncodeUserCachesDirectory.stringByAppendingFormat("/\(user)").stringByAppendingString("/\(document)")
        if !manager.fileExists(atPath: path) {
            do {
                try manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
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


