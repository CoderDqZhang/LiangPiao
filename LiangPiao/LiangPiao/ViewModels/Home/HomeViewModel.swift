//
//  HomeViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa
import MJExtension

class HomeViewModel: NSObject {
    
    var models = NSMutableArray()
    var searchModel:RecommentTickes!
    var controller:HomeViewController!
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewModel.userDidTakeScreenshot(_:)), name: UIApplicationUserDidTakeScreenshotNotification, object: nil)
    }
    
    func userDidTakeScreenshot(notifiation:NSNotification){
        let image = KWINDOWDS().screenshot()
        SaveImageTools.sharedInstance.saveImage("ScreenShotImage.png", image: image, path: "ScreenShot")
        if KWINDOWDS().viewWithTag(10000) != nil {
            KWINDOWDS().viewWithTag(10000)?.removeFromSuperview()
        }
        KWINDOWDS().addSubview(GloableShareView.init(title: "分享截屏给好友", model: nil, image: image, url: nil))
    }
    
    func numberOfSectionsInTableView() -> Int{
        return 2
    }
    
    func numberOfRowsInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 2
        default:
            if models.count > 0{
                return models.count + 2
            }
            return 1
        }
    }
    
    func tableViewHeightForFooterInSection(section:Int) -> CGFloat {
        switch section {
        case 1:
            return 0.0001
        default:
            return 10
        }
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat
    {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 255
            case 1:
                return 100
            default:
                return 152
            }
        default:
            switch indexPath.row {
            case 0:
                return 57
            case self.numberOfRowsInSection(indexPath.section) - 1:
                return 79
            default:
                return 140
            }
        }
    }
    
    func navigationPushTicketPage(index:Int) {
        let ticketPage = TicketPageViewController()
        ticketPage.progressHeight = 0
        ticketPage.progressWidth = 0
        ticketPage.adjustStatusBarHeight = true
        ticketPage.progressColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        ticketPage.hidesBottomBarWhenPushed = true
        if index == 4 {
            ticketPage.pageViewControllerDidSelectIndexPath(0)
        }else{
            ticketPage.pageViewControllerDidSelectIndexPath(index + 1)
        }
        NavigationPushView(controller, toConroller: ticketPage)
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath) {
        switch indexPath.section {
        case 0:
            break;
        default:
            switch indexPath.row {
            case 0:
                break;
            case self.numberOfRowsInSection(indexPath.section) - 1:
                self.navigationPushTicketPage(4)
            default:
                let model = TicketShowModel.init(fromDictionary: models.objectAtIndex(indexPath.row - 1) as! NSDictionary)
                if model.sessionCount == 1 {
                    let controllerVC = TicketDescriptionViewController()
                    controllerVC.viewModel.ticketModel = model
                    NavigationPushView(controller, toConroller: controllerVC)
                }else{
                    let controllerVC = TicketSceneViewController()
                    controllerVC.viewModel.model = model
                    NavigationPushView(controller, toConroller: controllerVC)
                }
            }
        }
    }
    
    func cellData(cell:RecommendTableViewCell, indexPath:NSIndexPath) {
        let model = TicketShowModel.init(fromDictionary: models.objectAtIndex(indexPath.row - 1) as! NSDictionary)
        cell.setData(model)
    }
    
    func requestHotTicket(tableView:UITableView){
        BaseNetWorke.sharedInstance.getUrlWithString(TickeHot, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            self.models = resultModels.mutableCopy() as! NSMutableArray
            tableView.reloadSections(NSIndexSet.init(index: 1), withRowAnimation: .Automatic)
            if tableView.mj_header != nil {
                tableView.mj_header.endRefreshing()
                self.controller.endRefreshView()
            }
        }
    }
    
}
