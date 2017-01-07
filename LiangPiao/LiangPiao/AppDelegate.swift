//
//  AppDelegate.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Alamofire
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WeiboSDKDelegate, JPUSHRegisterDelegate {

    var window: UIWindow?

    var spalshView:SpalshView!
    
    var wbtoken:String!
        
    func addSplshView() {
        
        spalshView = SpalshView(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.window!.addSubview(spalshView)
        NSTimer.YQ_scheduledTimerWithTimeInterval(100, closure: { 
            self.spalshView.removeFromSuperview()
            }, repeats: false)
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        if UserInfoModel.isLoggedIn() {
            if UserInfoModel.shareInstance().role == nil {
                UserInfoModel.logout()
            }
        }
        AppleThemeTool.setUpToolBarColor()
        AppleThemeTool.setUpKeyBoardManager()
        
        TalkingData.setExceptionReportEnabled(true)
        TalkingData.sessionStarted(TalkingDataKey, withChannelId: "AppStore")
        
        self.logUser()
        Crashlytics.sharedInstance().debugMode = true
        Fabric.with([Crashlytics.self])
        WXApi.registerApp(WeiXinAppID)
        WeiboSDK.registerApp(WeiboApiKey)
        WeiboSDK.enableDebugMode(true)
        TalkingData.setExceptionReportEnabled(true)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
        
        self.window?.makeKeyAndVisible()
//        self.addSplshView()
        self.addNotification(launchOptions,application:application)
        self.addGaoDeMap(application)
        return true
    }
    
    func addGaoDeMap(application:UIApplication) {
        AMapServices.sharedServices().apiKey = GaoDeApiKey
    }
    
    func addNotification(launchOptions:[NSObject : AnyObject]?,application:UIApplication){
        
        if (UIDevice.currentDevice().systemVersion.floatValue >= 10.0) {
            // 可以自定义 categories
            let entity = JPUSHRegisterEntity.init()
//            entity.types = (Int(UIUserNotificationType.Sound.rawValue) | Int(UIUserNotificationType.Badge.rawValue) | Int(UIUserNotificationType.Alert.rawValue))
            JPUSHService.registerForRemoteNotificationConfig(entity, delegate: self)
        } else if (UIDevice.currentDevice().systemVersion.floatValue >= 8.0) {
            JPUSHService.registerForRemoteNotificationTypes(UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Alert.rawValue , categories: nil)
        }else {
            JPUSHService.registerForRemoteNotificationTypes(UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Alert.rawValue , categories: nil)
        }
        JPUSHService.setupWithOption(launchOptions, appKey: JPushApiKey, channel: "channel", apsForProduction: false)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(center: UNUserNotificationCenter!, willPresentNotification notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
//        self.contentHandler = contentHandler
//        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//        
        let userInfo = notification.request.content.userInfo as NSDictionary
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo as [NSObject : AnyObject])
        }
        completionHandler(Int(UIUserNotificationType.Sound.rawValue) | Int(UIUserNotificationType.Badge.rawValue) | Int(UIUserNotificationType.Alert.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(center: UNUserNotificationCenter!, didReceiveNotificationResponse response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo as NSDictionary
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo as [NSObject : AnyObject])
        }
        if userInfo.objectForKey("type") as! String == "ticketDescrip" {
            let url = "\(TickeSession)\((userInfo.objectForKey("show_id")!))/session/\((userInfo.objectForKey("session_id")!))"
            NSNotificationCenter.defaultCenter().postNotificationName(DidRegisterRemoteNotification, object: url)
        }else if userInfo.objectForKey("type") as! String == "ticketDescrip" {
            let url = "\((userInfo.objectForKey("url")!))"
            NSNotificationCenter.defaultCenter().postNotificationName(DidRegisterRemoteURLNotification, object: url)
        }
        completionHandler()
    }
    
    func logUser(){
        Crashlytics.sharedInstance().setUserIdentifier(UserInfoModel.shareInstance().id)
        Crashlytics.sharedInstance().setUserName(UserInfoModel.shareInstance().phone)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        SHARE_APPLICATION.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
        SHARE_APPLICATION.cancelAllLocalNotifications()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        //可以在这个方法里做一些后台操作（下载数据，更新UI等），记得修改Background Modes。
        if IPHONE_VERSION_LAST10 == 1 {
            JPUSHService.handleRemoteNotification(userInfo)
        }else{
            if (userInfo as NSDictionary).objectForKey("type") as! String == "ticketDescrip" {
                let url = "\(TickeSession)\(((userInfo as NSDictionary).objectForKey("show_id")!))/session/\(((userInfo as NSDictionary).objectForKey("session_id")!))"
                NSNotificationCenter.defaultCenter().postNotificationName(DidRegisterRemoteNotification, object: url)
            }else if (userInfo as NSDictionary).objectForKey("type") as! String == "ticketDescrip" {
                let url = "\(((userInfo as NSDictionary).objectForKey("url")!))"
                NSNotificationCenter.defaultCenter().postNotificationName(DidRegisterRemoteURLNotification, object: url)
            }
        }
        completionHandler(.NewData)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("DEVICE TOKEN = \(deviceToken)")
        NSNotificationCenter.defaultCenter().postNotificationName(DidRegisterRemoteDiviceToken, object: deviceToken)
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
    
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        if url.host == "response_from_qq" {
            return TencentOAuth.HandleOpenURL(url)
        }
        if url.host == "platformId=wechat" || url.host == "pay" {
            return WXApi.handleOpenURL(url, delegate: self)
        }
        return WeiboSDK.handleOpenURL(url, delegate: self)
//
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (resultDic) in
                if resultDic["resultStatus"] as! String == "9000" {
                    Notification(OrderStatuesChange, value: "3")
                }else{
                    Notification(OrderStatuesChange, value: "100")
                    MainThreseanShowAliPayError(resultDic["resultStatus"] as! String)
                }
            })
            return true
        }
        
        if url.host == "response_from_qq" {
            return TencentOAuth.HandleOpenURL(url)
        }
        if url.host == "platformId=wechat" || url.host == "pay" {
            return WXApi.handleOpenURL(url, delegate: self)
        }
        
        return WeiboSDK.handleOpenURL(url, delegate: self)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (resultDic) in
                print(resultDic)
            })
            
            AlipaySDK.defaultService().processAuthResult(url, standbyCallback: { (resultDic) in
                print(resultDic)
            })
            
            return true
        }
        if url.host == "response_from_qq" {
            return TencentOAuth.HandleOpenURL(url)
        }
        if url.host == "platformId=wechat" || url.host == "pay" {
            return WXApi.handleOpenURL(url, delegate: self)
        }
        return WeiboSDK.handleOpenURL(url, delegate: self)
    }
    //MARK: 微博SDKDelegate
    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(response: WBBaseResponse!) {
        if response is WBShareMessageToContactResponse {
            print(response.statusCode)
        }
    }
}

extension AppDelegate : WXApiDelegate {
    func onReq(req: BaseReq!) {
        
    }
    
    func onResp(resp: BaseResp!) {
        if resp is PayResp {
            switch resp.errCode {
            case 0:
                Notification(OrderStatuesChange, value: "3")
//                print("展示成功页面")
            case -1:
                Notification(OrderStatuesChange, value: "100")
                MainThreadAlertShow("微信支付错误", view: KWINDOWDS())
//                print("可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。")
            case -2:
                Notification(OrderStatuesChange, value: "100")
                MainThreadAlertShow("取消支付", view: KWINDOWDS())
//                print("无需处理。发生场景：用户不支付了，点击取消，返回APP。")
            default:
                break;
            }
        }else if resp is SendMessageToWXResp {
            switch resp.errCode {
            case -2:
                MainThreadAlertShow("取消分享", view: KWINDOWDS())
            default:
                break;
            }
        }
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        let categoryIdentifier = response.notification.request.content.categoryIdentifier
        print(categoryIdentifier)
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        //如果需要在应用在前台也展示通知
        completionHandler([.Sound, .Alert, .Badge])
    }
}

