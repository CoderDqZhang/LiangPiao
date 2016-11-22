//
//  SettingViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SettingViewModel: NSObject {

    let titleLabel = ["关于我们","意见反馈","赏个好评"]
    override init() {
        
    }
    
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        return 51
    }
    
    func cellTitle(indexPath:NSIndexPath) -> String {
        if indexPath.section == 0 {
            return titleLabel[indexPath.row]
        }else{
            return "退出登录"
        }
    }
    
    func cellDetail(indexPath:NSIndexPath) -> String {
        return ""
    }
    
    func tableViewDidSelect(indexPath:NSIndexPath, controller:SettingViewController) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let controllers = storyBoard.instantiateViewControllerWithIdentifier("AboutUsViewController") as! AboutUsViewController
                controllers.hidesBottomBarWhenPushed = true
                controller.navigationController?.pushViewController(controllers, animated: true)
            default:
                break
            }
        default:
            if UserInfoModel.shareInstance().deleteObject() {
                Notification(LoginStatuesChange, value: nil)
                controller.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
}
