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
    
    var backgroundTime:Timer!
    
    var loginTime:Int = 0
    
    var backgroundTaskIdentifier:UIBackgroundTaskIdentifier!
        
    func addSplshView() {
        
        spalshView = SpalshView(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.window!.addSubview(spalshView)
        _ = Timer.YQ_scheduledTimerWithTimeInterval(100, closure: {
            self.spalshView.removeFromSuperview()
            }, repeats: false)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if UserInfoModel.isLoggedIn() {
            if UserInfoModel.shareInstance().role == nil {
                UserInfoModel.logout()
            }
        }
        
        UserDefaultsSetSynchronize("payOrder" as AnyObject, key: "PayType")
        
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
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        
        self.window?.makeKeyAndVisible()
//        self.addSplshView()
        self.addNotification(launchOptions,application:application)
        self.addGaoDeMap(application)
        return true
    }
    
    func endBackGroundTask(){
        if self.backgroundTime != nil {
            DispatchQueue.main.async {
                self.backgroundTime.invalidate()
                SHARE_APPLICATION.endBackgroundTask(self.backgroundTaskIdentifier)
                self.backgroundTaskIdentifier = UIBackgroundTaskInvalid
            }
        }
    }
    
    
    func addGaoDeMap(_ application:UIApplication) {
        AMapServices.shared().apiKey = GaoDeApiKey
    }
    
    func setJPushTag(){
        if UserInfoModel.isLoggedIn() {
            JPUSHService.setTags(nil, alias: UserInfoModel.shareInstance().phone, fetchCompletionHandle: { (id, tag, alias) in
                print(id)
            })
      }
    }
    
    func addNotification(_ launchOptions:[AnyHashable: Any]?,application:UIApplication){
        
        if (UIDevice.current.systemVersion.floatValue >= 10.0) {
            // 可以自定义 categories
            let entity = JPUSHRegisterEntity.init()
            entity.types = Int(UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.alert.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        } else if (UIDevice.current.systemVersion.floatValue >= 8.0) {
            JPUSHService.register(forRemoteNotificationTypes: UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.alert.rawValue , categories: nil)
        }else {
            JPUSHService.register(forRemoteNotificationTypes: UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.alert.rawValue , categories: nil)
        }
        JPUSHService.setup(withOption: launchOptions, appKey: JPushApiKey, channel: "App Store", apsForProduction: true)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {        
        let userInfo = notification.request.content.userInfo as NSDictionary
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo as! [AnyHashable: Any])
        }
        completionHandler(Int(UIUserNotificationType.sound.rawValue) | Int(UIUserNotificationType.badge.rawValue) | Int(UIUserNotificationType.alert.rawValue))
    }
    
    /*
     userInfo 
     {
     "url" : "http:\/\/www.liangpiao.me\/show\/3535216740\/session\/3535216964\/",
     "_j_business" : 1,
     "_j_uid" : 9479888424,
     "session_id" : 3535216964,
     "show_id" : 3535216740,
     "title" : "赶快来抢票",
     "type" : "ticketDescrip",
     "_j_msgid" : 2362856356,
     "imageAbsoluteString" : "http:\/\/7xsatk.com1.z0.glb.clouddn.com\/507aa7a89b37541d8e34daa8ac7baf6c.jpg?imageMogr\/v2\/format\/jpg\/thumbnail\/277x373",
     "aps" : {
     "mutable-content" : 1,
     "alert" : "「上海站」张学友《A CLASSIC TOUR》世界巡回演唱会",
     "badge" : 1,
     "sound" : "default"
     }
 */
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo as NSDictionary
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo as! [AnyHashable: Any])
        }
        print("".dataTojsonString(userInfo))
        if userInfo.object(forKey: "type") != nil {
            if userInfo.object(forKey: "type") as! String == "ticketDescrip" {
                let url = "\(TickeSession)\((userInfo.object(forKey: "show_id")!))/session/\((userInfo.object(forKey: "session_id")!))"
                NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: DidRegisterRemoteNotification), object: url)
            }else if userInfo.object(forKey: "type") as! String == "operation" {
                let url = "\((userInfo.object(forKey: "url")!))"
                NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: DidRegisterRemoteURLNotification), object: url)
            }
        }
        completionHandler()
    }
    
    func logUser(){
        Crashlytics.sharedInstance().setUserIdentifier(UserInfoModel.shareInstance().id)
        Crashlytics.sharedInstance().setUserName(UserInfoModel.shareInstance().phone)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.backgroundTaskIdentifier = application.beginBackgroundTask(expirationHandler: {
            self.endBackGroundTask()
        })
        if UserDefaultsGetSynchronize("isLoginTime") as! String != "nil" {
            loginTime = UserDefaultsGetSynchronize("backGroundTime") as! Int
            UserDefaultsSetSynchronize("true" as AnyObject, key: "isLoginEnterBack")
            self.backgroundTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AppDelegate.timerMethod(_:)), userInfo: nil, repeats: true)
        }else{
            UserDefaultsSetSynchronize(0 as AnyObject, key: "backGroundTime")
        }
        
    }
    
    func timerMethod(_ paramSender:Timer){
        if loginTime > 59 {
            self.endBackGroundTask()
        }
        loginTime = loginTime + 1
        UserDefaultsSetSynchronize(loginTime as AnyObject, key: "backGroundTime")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        SHARE_APPLICATION.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
        SHARE_APPLICATION.cancelAllLocalNotifications()
        self.endBackGroundTask()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //可以在这个方法里做一些后台操作（下载数据，更新UI等），记得修改Background Modes。
        if IPHONE_VERSION_LAST10 == 1 {
            JPUSHService.handleRemoteNotification(userInfo)
        }else{
            if (userInfo as NSDictionary).object(forKey: "type") != nil {
                if (userInfo as NSDictionary).object(forKey: "type") as! String == "ticketDescrip" {
                    let url = "\(TickeSession)\(((userInfo as NSDictionary).object(forKey: "show_id")!))/session/\(((userInfo as NSDictionary).object(forKey: "session_id")!))"
                    NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: DidRegisterRemoteNotification), object: url)
                }else if (userInfo as NSDictionary).object(forKey: "type") as! String == "operation" {
                    let url = "\(((userInfo as NSDictionary).object(forKey: "url")!))"
                    NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: DidRegisterRemoteURLNotification), object: url)
                }
            }
        }
        completionHandler(.newData)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: DidRegisterRemoteDiviceToken), object: deviceToken)
        JPUSHService.registerDeviceToken(deviceToken)
        self.setJPushTag()
    }
    
    private func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if url.host == "response_from_qq" {
            return TencentOAuth.handleOpen(url)
        }
        if url.host == "platformId=wechat" || url.host == "pay" {
            return WXApi.handleOpen(url, delegate: self)
        }
        return WeiboSDK.handleOpen(url, delegate: self)
//
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                if resultDic?["resultStatus"] as! String == "9000" {
                    if UserDefaultsGetSynchronize("PayType") as! String == "payOrder" {
                        Notification(OrderStatuesChange, value: "3")
                    }else{
                        Notification(UserTopUpWall, value: "3")
                    }
                    
                }else{
                    if UserDefaultsGetSynchronize("PayType") as! String == "payOrder" {
                        Notification(OrderStatuesChange, value: "100")
                    }else{
                        Notification(UserTopUpWall, value: "100")
                    }
                    MainThreseanShowAliPayError(resultDic?["resultStatus"] as! String)
                }
            })
            return true
        }
        
        if url.host == "response_from_qq" {
            return TencentOAuth.handleOpen(url)
        }
        if url.host == "platformId=wechat" || url.host == "pay" {
            return WXApi.handleOpen(url, delegate: self)
        }
        
        return WeiboSDK.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
            })
            
            AlipaySDK.defaultService().processAuthResult(url, standbyCallback: { (resultDic) in
            })
            
            return true
        }
        if url.host == "response_from_qq" {
            return TencentOAuth.handleOpen(url)
        }
        if url.host == "platformId=wechat" || url.host == "pay" {
            return WXApi.handleOpen(url, delegate: self)
        }
        return WeiboSDK.handleOpen(url, delegate: self)
    }
    //MARK: 微博SDKDelegate
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        if response is WBShareMessageToContactResponse {
            print(response.statusCode)
        }
    }
}

extension AppDelegate : WXApiDelegate {
    func onReq(_ req: BaseReq!) {
        
    }
    
    func onResp(_ resp: BaseResp!) {
        if resp is PayResp {
            switch resp.errCode {
            case 0:
                if UserDefaultsGetSynchronize("PayType") as! String == "payOrder" {
                    Notification(OrderStatuesChange, value: "3")
                }else{
                    Notification(UserTopUpWall, value: "3")
                }
//                print("展示成功页面")
            case -1:
                if UserDefaultsGetSynchronize("PayType") as! String == "payOrder" {
                    Notification(OrderStatuesChange, value: "100")
                }else{
                    Notification(UserTopUpWall, value: "100")
                }
                MainThreadAlertShow("微信支付错误", view: KWINDOWDS())
//                print("可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。")
            case -2:
                if UserDefaultsGetSynchronize("PayType") as! String == "payOrder" {
                    Notification(OrderStatuesChange, value: "100")
                }else{
                    Notification(UserTopUpWall, value: "100")
                }
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
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let categoryIdentifier = response.notification.request.content.categoryIdentifier
        print(categoryIdentifier)
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //如果需要在应用在前台也展示通知
        completionHandler([.sound, .alert, .badge])
    }
}

