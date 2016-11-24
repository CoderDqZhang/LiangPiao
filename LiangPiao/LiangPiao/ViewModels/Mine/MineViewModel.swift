//
//  MineViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

typealias ReloadTableView = () ->Void

class MineViewModel: NSObject {

    var reloaTable:RACSignal!
    var reloadTableView:ReloadTableView!
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MineViewModel.reloadTaleView), name: LoginStatuesChange, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    // MARK: - Data
    
    func reloadTaleView(){
        if self.reloadTableView != nil {
            self.reloadTableView()
        }
    }
    
    // MARK: - TableViewDelege
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        if section == 0 {
            return 1
        }
        return 4
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        switch indexPath.section {
        case 0:
            return 255
        default:
            switch indexPath.row {
            case 3:
                return SCREENHEIGHT - 282 - 164 > 130 ? SCREENHEIGHT - 282 - 164 : 130
            default:
                return 48
            }
        }
    }
    
    func cellTitle(indexPathRow:Int) -> String {
        switch indexPathRow {
        case 0:
            return "想看的演出"
        case 1:
            return "地址管理"
        case 2:
            return "设置"
        default:
            return ""
        }
    }
    
    func cellImage(indexPathRow:Int) -> UIImage {
        switch indexPathRow {
        case 0:
            return UIImage.init(named: "Icon_Favorite")!
        case 1:
            return UIImage.init(named: "Icon_Address")!
        case 2:
            return UIImage.init(named: "Icon_Settings")!
        default:
            return UIImage.init(named: "Icon_Settings")!
        }
    }
    
    func tableViewDidSelect(indexPath:NSIndexPath, controller:UIViewController) {
        switch indexPath.section {
        case 0:
            if UserInfoModel.isLoggedIn() {
                NavigationPushView(controller, toConroller: MyProfileViewController())
            }else{
                NavigationPushView(controller, toConroller: LoginViewController())
            }
        
        default:
            switch indexPath.row {
            case 0:
                if UserInfoModel.isLoggedIn() {
                    NavigationPushView(controller, toConroller: FavoriteViewController())
                }else{
                    NavigationPushView(controller, toConroller: LoginViewController())
                }
            case 1:
                if UserInfoModel.isLoggedIn() {
                    NavigationPushView(controller, toConroller: AddressViewController())
                }else{
                    NavigationPushView(controller, toConroller: LoginViewController())
                }
            case 2:
                NavigationPushView(controller, toConroller: SettingViewController())
            default:
                break;
            }
        }
    }
    
    func tableViewPhotoCell(cell:MineHeadTableViewCell){
        if !UserInfoModel.isLoggedIn() {
            cell.setData("注册 / 登录", photoImage:"Avatar_Default", isLogin: false)
        }else{
            cell.setData(UserInfoModel.shareInstance().username, photoImage: UserInfoModel.shareInstance().avatar, isLogin: true)

        }
    }
}
