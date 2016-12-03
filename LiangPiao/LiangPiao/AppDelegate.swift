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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var spalshView:SpalshView!
    
    func addSplshView() {
        
        spalshView = SpalshView(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.window!.addSubview(spalshView)
        NSTimer.YQ_scheduledTimerWithTimeInterval(100, closure: { 
            self.spalshView.removeFromSuperview()
            }, repeats: false)
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        AppleThemeTool.setUpToolBarColor()
        AppleThemeTool.setUpToolBarColor()
        AppleThemeTool.setUpKeyBoardManager()
        
        TalkingData.setExceptionReportEnabled(true)
        TalkingData.sessionStarted(TalkingDataKey, withChannelId: "AppStore")
        
        self.logUser()
        Crashlytics.sharedInstance().debugMode = true
        Fabric.with([Crashlytics.self])
        
        WXApi.registerApp(WeiXinAppID)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
        self.window?.makeKeyAndVisible()
//        self.addSplshView()
        return true
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
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
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
        return WXApi.handleOpenURL(url, delegate: self)
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
        return WXApi.handleOpenURL(url, delegate: self)
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
                MainThreadAlertShow("微信支付错误", view: KWINDOWDS!)
//                print("可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。")
            case -2:
                Notification(OrderStatuesChange, value: "100")
                MainThreadAlertShow("取消支付", view: KWINDOWDS!)
//                print("无需处理。发生场景：用户不支付了，点击取消，返回APP。")
            default:
                break;
            }
        }
    }
}

