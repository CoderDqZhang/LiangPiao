//
//  Define.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation
import UIKit

let SCREENWIDTH = UIScreen.mainScreen().bounds.size.width
let SCREENHEIGHT = UIScreen.mainScreen().bounds.size.height

let IPHONE_VERSION = UIDevice.currentDevice().systemVersion.floatValue
let IPHONE_VERSION_LAST9 = UIDevice.currentDevice().systemVersion.floatValue >= 9 ? 1:0

let IPHONE4 = SCREENHEIGHT == 480 ? true:false
let IPHONE5 = SCREENHEIGHT == 568 ? true:false
let IPHONE6 = SCREENWIDTH == 344 ? true:false
let IPHONE6P = SCREENWIDTH == 344 ? true:false


let WeiXinPayStatues = "WeiXinPayStatuesChange"
let AliPayStatues = "AliPayStatuesChange"

let ToolViewNotifacationName = "ToolsViewNotification"

let KWINDOWDS = UIApplication.sharedApplication().keyWindow


func AppCallViewShow(view:UIView, phone:String) {
    dispatch_async(dispatch_get_main_queue()) { 
        let str = "tel:\(phone)"
        let callWebView = UIWebView()
        callWebView.loadRequest(NSURLRequest(URL: NSURL.init(string: str)!))
        view.addSubview(callWebView)
    }
}

func UserDefaultsSetSynchronize(value:AnyObject,key:String) {
    NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
    NSUserDefaults.standardUserDefaults().synchronize()
}

func UserDefaultsGetSynchronize(key:String) -> Any{
    return NSUserDefaults.standardUserDefaults().objectForKey(key)
}

func Storyboard(name:String,controllerid:String) -> UIViewController{
    return UIStoryboard.init(name: name, bundle: nil).instantiateViewControllerWithIdentifier(controllerid)
}

func Notification(name:String,value:String) {
    NSNotificationCenter.defaultCenter().postNotificationName(name, object: value)
}





