//
//  SettingViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import MessageUI
import Alamofire

class SettingViewModel: NSObject, MFMailComposeViewControllerDelegate {

    let titleLabel = ["关于我们","意见反馈","赏个好评"]
    override init() {
        
    }
    
    func numberOfSection() ->Int {
        if UserInfoModel.isLoggedIn() {
            return 2
        }
        return 1
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        switch section {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        return 51
    }
    
    func cellTitle(_ indexPath:IndexPath) -> String {
        if indexPath.section == 0 {
            return titleLabel[indexPath.row]
        }else{
            return "退出登录"
        }
    }
    
    func cellDetail(_ indexPath:IndexPath) -> String {
        return ""
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, controller:SettingViewController) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let controllers = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
                controllers.hidesBottomBarWhenPushed = true
                controller.navigationController?.pushViewController(controllers, animated: true)
            case 1:
                self.presentEmailViewController(controller)
                break;
            default:
                UIApplication.shared.openURL(URL.init(string: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1170039060")!)
                break
            }
        default:
            if UserInfoModel.shareInstance().deleteObject() {
                Notification(LoginStatuesChange, value: nil)
                controller.navigationController?.popViewController(animated: true)
//                Alamofire.Manager.sharedInstance.session = nil
            }
        }
    }
    
    func presentEmailViewController(_ controller:SettingViewController){
        guard MFMailComposeViewController.canSendMail() else {
            MainThreadAlertShow("不能发送邮箱，请设置邮箱账号", view: KWINDOWDS())
            return
        }
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self // 代理
        mailVC.setSubject("意见反馈") // 主题
        mailVC.setToRecipients(["feedback@liangpiao.me"]) // 收件人
        mailVC.setMessageBody("相关内容", isHTML: false) // 内容，允许使用html内容
        
        controller.present(mailVC, animated: true, completion: nil)
    }
    
    @nonobjc func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
        controller.dismiss(animated: true) {
            
        }
    }
}
