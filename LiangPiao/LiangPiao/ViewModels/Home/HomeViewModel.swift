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
    override init() {
        
    }
    
    func numberOfSectionsInTableView() -> Int{
        return 2
    }
    
    func numberOfRowsInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 2
        default:
            return models.count + 1
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
            default:
                return 140
            }
        }
    }
    
    func navigationPushTicketPage(index:Int, controller:HomeViewController) {
        let ticketPage = TicketPageViewController()
        ticketPage.progressHeight = 0
        ticketPage.progressWidth = 0
        ticketPage.adjustStatusBarHeight = true
        ticketPage.progressColor = UIColor.init(hexString: TablaBarItemTitleSelectColor)
        ticketPage.hidesBottomBarWhenPushed = true
        if index == 4 {
            ticketPage.pageViewControllerDidSelectIndexPath(0)
        }else{
            ticketPage.pageViewControllerDidSelectIndexPath(index + 1)
        }
        controller.navigationController?.pushViewController(ticketPage, animated: true)
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath, controller:HomeViewController) {
        switch indexPath.section {
        case 0:
            break;
        default:
            if indexPath.row != 0 {
                let controllerVC = TicketSceneViewController()
                controllerVC.viewModel.model = HomeTicketModel.init(fromDictionary: models.objectAtIndex(indexPath.row - 1) as! NSDictionary)
               NavigationPushView(controller, toConroller: controllerVC)
            }
        }
        
    }
    
    func cellData(cell:RecommendTableViewCell, indexPath:NSIndexPath) {
        let model = HomeTicketModel.init(fromDictionary: models.objectAtIndex(indexPath.row - 1) as! NSDictionary)
        cell.setData(model)
    }
    
    func requestHotTicket(tableView:UITableView){
        BaseNetWorke.sharedInstance.getUrlWithString(TickeHot, parameters: nil).subscribeNext { (resultDic) in
            if  ((resultDic is NSDictionary) && (resultDic as! NSDictionary).objectForKey("fail") != nil) {
                print("请求失败")
            }else{
                let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
                self.models = resultModels.mutableCopy() as! NSMutableArray
                tableView.reloadSections(NSIndexSet.init(index: 1), withRowAnimation: .Automatic)
            }
        }
    }
}
