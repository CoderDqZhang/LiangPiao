//
//  TicketSessionViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 22/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketSessionViewModel: NSObject {

    var models = NSMutableArray()
    var model:HomeTicketModel!
    
    override init() {
        
    }
    
    func numberOfSectionsInTableView() -> Int{
        return 2
    }
    
    func numberOfRowsInSection(section:Int) ->Int {
        return models.count
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
        switch indexPath.row {
        case 0:
            return 70
        default:
            return 60
        }
    }
    
    func requestTicketSession(tableView:UITableView){
        let url = "\(TickeSession)\(model.id)/session"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            self.models = resultModels.mutableCopy() as! NSMutableArray
            tableView.reloadData()
        }
    }
    
    func didSelectRowAtIndexPath(indexPath:NSIndexPath,controller:TicketSceneViewController) {
        let controllerVC = TicketDescriptionViewController()
        controllerVC.viewModel.ticketModel = model
        NavigationPushView(controller, toConroller: controllerVC)
    }
    
    func cellForRowAtIndexPath(indexPath:NSIndexPath,cell:TicketSceneTableViewCell){
        let model = TicketSessionModel.init(fromDictionary: models.objectAtIndex(indexPath.row) as! NSDictionary)
        cell.setData(model)
    }
}
