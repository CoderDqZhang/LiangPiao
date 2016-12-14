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

let AnimationTime = 0.3

let TitleLineSpace:Float = 3.0


let WeiXinPayStatues = "WeiXinPayStatuesChange"
let AliPayStatues = "AliPayStatuesChange"

let WeiXinAppID = "wx6c6b940e660449a2"

let ToolViewNotifacationName = "ToolsViewNotification"
let LoginStatuesChange = "LoginStatuesChange"

let OrderStatuesChange = "OrderStatusChange"

let BlanceNumberChange = "BlanceNumberChange"



let TalkingDataKey = "AC559E27399F4ECEA0D9880E0C6977FB"

let KWINDOWDS = UIApplication.sharedApplication().keyWindow


func AppCallViewShow(view:UIView, phone:String) {
    UIAlertController.shwoAlertControl(view.findViewController()!, title: nil, message: phone, cancel: "取消", doneTitle: "确定", cancelAction: {
        
        }, doneAction: {
           UIApplication.sharedApplication().openURL(NSURL.init(string: "tel:\(phone)")!)
    })
}

func UserDefaultsSetSynchronize(value:AnyObject,key:String) {
    NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
    NSUserDefaults.standardUserDefaults().synchronize()
}

func UserDefaultsGetSynchronize(key:String) -> AnyObject{
    if NSUserDefaults.standardUserDefaults().objectForKey(key) == nil {
        return "nil"
    }
    return NSUserDefaults.standardUserDefaults().objectForKey(key)!
}

func Storyboard(name:String,controllerid:String) -> UIViewController{
    return UIStoryboard.init(name: name, bundle: nil).instantiateViewControllerWithIdentifier(controllerid)
}

func Notification(name:String,value:String?) {
    NSNotificationCenter.defaultCenter().postNotificationName(name, object: value)
}


func NavigationPushView(formviewController:UIViewController, toConroller:UIViewController) {
    toConroller.hidesBottomBarWhenPushed = true
    formviewController.navigationController?.pushViewController(toConroller, animated: true)
}

func MainThreadAlertShow(msg:String,view:UIView){
    dispatch_async(dispatch_get_main_queue(), {
        Tools.shareInstance.showMessage(view, msg: msg, autoHidder: true)
    })
}

func MainThreanShowErrorMessage(error:AnyObject){
    if error is NSDictionary {
        dispatch_async(dispatch_get_main_queue(), {
            Tools.shareInstance.showErrorMessage(error)
        })
    }
}

func MainThreanShowNetWorkError(error:AnyObject){
    dispatch_async(dispatch_get_main_queue(), {
        Tools.shareInstance.showNetWorkError(error)
    })
}


func MainThreseanShowAliPayError(error:String) {
    var aliPayError = ""
    switch error {
    case "4000":
        aliPayError = "订单支付失败"
    case "5000":
        aliPayError = "重复请求"
    case "6001":
        aliPayError = "用户中途取消"
    case "6002":
        aliPayError = "网络连接出错"
    case "8000":
        aliPayError = "正在处理中"
    default:
        break
    }
    dispatch_async(dispatch_get_main_queue(), {
        Tools.shareInstance.showAliPathError(aliPayError)
    })
}



