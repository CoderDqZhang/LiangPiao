//
//  MineViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveSwift

typealias ReloadTableView = () ->Void

class MineViewModel: NSObject {

//    var reloaTable:SignalProducer!
    var reloadTableView:ReloadTableView!
    var numberOfSell:Int = 0
    var controller:MineViewController!
    let cellTitle = ["我的钱包","我的卖票","想看的演出","地址管理","设置",""]
    let cellImage = [UIImage.init(named: "Icon_Wallet")!,UIImage.init(named: "Icon_Sell")!,UIImage.init(named: "Icon_Favorite")!,UIImage.init(named: "Icon_Address")!,UIImage.init(named: "Icon_Settings")!,UIImage.init(named: "Icon_Settings")!]
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(MineViewModel.reloadTaleView), name: NSNotification.Name(rawValue: LoginStatuesChange), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        if section == 0 {
            return 1
        }
        return 6
    }
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
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
    
    func tableViewGloabImageTitleAndImageCell(_ cell:GloabImageTitleAndImageCell,indexPath:IndexPath) {
        cell.setData(self.cellTitle[indexPath.row], infoImage: self.cellImage[indexPath.row])
        if indexPath.row == 1 && numberOfSell != 0 {
            let label = controller.createCustomLabel()
            label.text = "\(numberOfSell)"
            let width = "\(numberOfSell)".widthWithConstrainedHeight("\(numberOfSell)", font: App_Theme_PinFan_M_11_Font!, height: 21) + 18
            cell.contentView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(cell.contentView.snp.centerY).offset(0)
                make.right.equalTo(cell.contentView.snp.right).offset(-39)
                make.size.equalTo(CGSize.init(width: width, height: 21))
            })
            cell.contentView.updateConstraintsIfNeeded()
        }
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, controller:MineViewController) {
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
    
    
    func navigationPushMysellPage(_ index:Int, controller:MineViewController) {
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
    
    func tableViewPhotoCell(_ cell:MineHeadTableViewCell){
        if !UserInfoModel.isLoggedIn() {
            cell.setData("注册 / 登录", photoImage:"Avatar_Default", isLogin: false)
        }else{
            cell.setData(UserInfoModel.shareInstance().username, photoImage: UserInfoModel.shareInstance().avatar, isLogin: true)

        }
    }
}
