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
        return 6
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        switch indexPath.section {
        case 0:
            return 255
        default:
            switch indexPath.row {
            case 5:
                return SCREENHEIGHT - 282 - 260 > 108 ? SCREENHEIGHT - 282 - 260 : 108
            default:
                return 48
            }
        }
    }
    
    func cellTitle(indexPathRow:Int) -> String {
        switch indexPathRow {
        case 0:
            return "我的钱包"
        case 1:
            return "我的卖票"
        case 2:
            return "想看的演出"
        case 3:
            return "地址管理"
        case 4:
            return "设置"
        default:
            return ""
        }
    }
    
    func cellImage(indexPathRow:Int) -> UIImage {
        switch indexPathRow {
        case 0:
            return UIImage.init(named: "Icon_Wallet")!
        case 1:
            return UIImage.init(named: "Icon_Sell")!
        case 2:
            return UIImage.init(named: "Icon_Favorite")!
        case 3:
            return UIImage.init(named: "Icon_Address")!
        case 4:
            return UIImage.init(named: "Icon_Settings")!
        default:
            return UIImage.init(named: "Icon_Settings")!
        }
    }
    
    func tableViewDidSelect(indexPath:NSIndexPath, controller:MineViewController) {
        switch indexPath.section {
        case 0:
            if UserInfoModel.isLoggedIn() {
                NavigationPushView(controller, toConroller: MyProfileViewController())
            }else{
                NavigationPushView(controller, toConroller: LoginViewController())
            }
        
        default:
            if indexPath.row == 4 {
//                NavigationPushView(controller, toConroller: OrderDeliveryTypeViewController())
                NavigationPushView(controller, toConroller: SettingViewController())
                return
            }else{
                if !UserInfoModel.isLoggedIn() {
                    NavigationPushView(controller, toConroller: LoginViewController())
                    return
                }
            }
            switch indexPath.row {
            case 0:
                NavigationPushView(controller, toConroller: MyWalletViewController())
            case 1:
                self.navigationPushMysellPage(0, controller: controller)
            case 2:
                NavigationPushView(controller, toConroller: FavoriteViewController())
            case 3:
                let controllerVC = AddressViewController()
                controllerVC.viewModel.addressType = .editType
                NavigationPushView(controller, toConroller: controllerVC)
            default:
                break;
            }
        }
    }
    
    
    func navigationPushMysellPage(index:Int, controller:MineViewController) {
        let mySellPager = MySellPagerViewController()
        mySellPager.progressHeight = 0
        mySellPager.progressWidth = 0
        mySellPager.adjustStatusBarHeight = true
        mySellPager.progressColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        mySellPager.hidesBottomBarWhenPushed = true
        if index == 4 {
            mySellPager.pageViewControllerDidSelectIndexPath(0)
        }else{
            mySellPager.pageViewControllerDidSelectIndexPath(index + 1)
        }
        NavigationPushView(controller, toConroller: mySellPager)
    }
    
    func tableViewPhotoCell(cell:MineHeadTableViewCell){
        if !UserInfoModel.isLoggedIn() {
            cell.setData("注册 / 登录", photoImage:"Avatar_Default", isLogin: false)
        }else{
            cell.setData(UserInfoModel.shareInstance().username, photoImage: UserInfoModel.shareInstance().avatar, isLogin: true)

        }
    }
}
