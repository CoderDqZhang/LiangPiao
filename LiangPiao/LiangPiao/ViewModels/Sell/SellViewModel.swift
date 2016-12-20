//
//  SellViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SellViewModel: NSObject {

    var controller:SellTicketsViewController!
    var models = NSMutableArray()
    
    override init() {
        
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat{
        return 140
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath) {
        if UserInfoModel.shareInstance().role == "supplier" {
            let model = TicketShowModel.init(fromDictionary: self.models.objectAtIndex(indexPath.row) as! NSDictionary)
            if model.sessionCount != 1 {
                let controllerVC = TicketSceneViewController()
                controllerVC.viewModel.model = model
                controllerVC.viewModel.isSellType = true
                NavigationPushView(controller, toConroller: controllerVC)
            }else{
                let controllerVC = MySellConfimViewController()
                controllerVC.viewModel.model = model
                controllerVC.viewModel.setUpViewModel()
                NavigationPushView(controller, toConroller: controllerVC)
            }
        }else{
            UIAlertController.shwoAlertControl(controller, style: .Alert, title: "请联系客服开通商家权限", message: nil, cancel: "取消", doneTitle: "联系删减", cancelAction: { 
                
                }, doneAction: {
                    AppCallViewShow(self.controller.view, phone: "400-873-8011")
            })
        }
    }
    
    func numberOfRowsInSection(section:Int) -> Int {
        return models.count
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    func tableViewtableViewSellRecommondTableViewCell(cell:SellRecommondTableViewCell, indexPath:NSIndexPath) {
        let model = self.models.objectAtIndex(indexPath.row)
        cell.setData(TicketShowModel.init(fromDictionary: model as! NSDictionary))
    }
    
    func requestHotTicket(){
        BaseNetWorke.sharedInstance.getUrlWithString(TickeHot, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            self.models = resultModels.mutableCopy() as! NSMutableArray
            self.controller.tableView.reloadData()
            if self.controller.tableView.mj_header != nil {
                self.controller.tableView.mj_header.endRefreshing()
            }
        }
    }
}
