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
    var model:TicketShowModel!
    var isSellType:Bool = false
    var controller:TicketSceneViewController!
    
    override init() {
        
    }
    
    func numberOfSectionsInTableView() -> Int{
        return 2
    }
    
    func numberOfRowsInSection(_ section:Int) ->Int {
        return models.count
    }
    
    func tableViewHeightForFooterInSection(_ section:Int) -> CGFloat {
        switch section {
        case 1:
            return 0.0001
        default:
            return 10
        }
    }
    
    func tableViewHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return 70
        default:
            return 60
        }
    }
    
    func requestTicketSession(_ tableView:UITableView){
        let url = "\(TickeSession)\((model.id)!)/session"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let resultModels =  NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
                self.models = resultModels?.mutableCopy() as! NSMutableArray
                tableView.reloadData()
            }
        }
    }
    
    func didSelectRowAtIndexPath(_ indexPath:IndexPath) {
        if isSellType {
            let controllerVC = MySellConfimViewController()
            model.session = ShowSessionModel.init(fromDictionary: self.models.object(at: indexPath.row) as! NSDictionary)
            controllerVC.viewModel.isChange = false
            controllerVC.viewModel.isSellTicketView = true
            controllerVC.viewModel.model = model
            controllerVC.viewModel.setUpViewModel()
            NavigationPushView(self.controller, toConroller: controllerVC)
        }else{
            let controllerVC = TicketDescriptionViewController()
            controllerVC.viewModel.ticketModel = model
            controllerVC.viewModel.ticketModel.session = ShowSessionModel.init(fromDictionary: self.models.object(at: indexPath.row) as! NSDictionary)
            NavigationPushView(self.controller, toConroller: controllerVC)
        }
    }
    
    func cellForRowAtIndexPath(_ indexPath:IndexPath,cell:TicketSceneTableViewCell){
        let model = ShowSessionModel.init(fromDictionary: models.object(at: indexPath.row) as! NSDictionary)
        cell.setData(model)
    }
}
