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
    
    func tableViewHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat{
        return 140
    }
    
    func tableViewDidSelectRowAtIndexPath(_ indexPath:IndexPath) {
        if UserInfoModel.isLoggedIn() {
            if UserInfoModel.shareInstance().role == "supplier" {
                self.pushSellViewController(indexPath)
            }else{
                BaseNetWorke.sharedInstance.getUrlWithString(UserInfoChange, parameters: nil).observe({ (resultDic) in
                    if !resultDic.isCompleted {
                        let model = UserInfoModel.mj_object(withKeyValues: resultDic.value)
                        UserInfoModel.shareInstance().avatar = model?.avatar
                        UserInfoModel.shareInstance().username = model?.username
                        UserInfoModel.shareInstance().id = model?.id
                        UserInfoModel.shareInstance().gender = (model?.gender)!
                        UserInfoModel.shareInstance().phone = UserInfoModel.shareInstance().phone
                        UserInfoModel.shareInstance().role = model?.role
                        model?.saveOrUpdate()
                        if UserInfoModel.shareInstance().role == "supplier" {
                            self.pushSellViewController(indexPath)
                        }else{
                            UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "您还非商家哦，可联系客服400-873-8011", message: nil, cancel: "取消", doneTitle: "联系客服", cancelAction: {
                                
                            }, doneAction: {
                                AppCallViewShow(self.controller.view, phone: "400-873-8011")
                            })
                        }
                    }else{
//                        UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "您还非商家哦，可联系客服400-873-8011", message: nil, cancel: "取消", doneTitle: "联系客服", cancelAction: {
//                            
//                        }, doneAction: {
//                            AppCallViewShow(self.controller.view, phone: "400-873-8011")
//                        })
                    }
                })
            }
        }else{
            NavigationPushView(controller, toConroller: LoginViewController())
        }
        
    }
    
    func pushSellViewController(_ indexPath:IndexPath){
        let model = TicketShowModel.init(fromDictionary: self.models.object(at: indexPath.row) as! NSDictionary)
        if model.sessionCount != 1 {
            let controllerVC = TicketSceneViewController()
            controllerVC.viewModel.model = model
            controllerVC.viewModel.isSellType = true
            NavigationPushView(self.controller, toConroller: controllerVC)
        }else{
            self.showMyTicketPutUpViewController(model)
            
        }
    }
    
    func numberOfRowsInSection(_ section:Int) -> Int {
        return models.count
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    func tableViewtableViewSellRecommondTableViewCell(_ cell:SellRecommondTableViewCell, indexPath:IndexPath) {
        let model = self.models.object(at: indexPath.row)
        cell.setData(TicketShowModel.init(fromDictionary: model as! NSDictionary))
    }
    
    func requestHotTicket(){
        BaseNetWorke.sharedInstance.getUrlWithString(HotSellURl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let resultModels =  NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
                self.models = resultModels?.mutableCopy() as! NSMutableArray
                self.controller.tableView.reloadData()
                if self.controller.tableView.mj_header != nil {
                    self.controller.tableView.mj_header.endRefreshing()
                }
            }
        }
    }
    
    func showMyTicketPutUpViewController(_ model:TicketShowModel){
        let url = "\(OneShowTicketUrl)\((model.id)!)/ticket/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let sessionList = NSMutableArray.mj_objectArray(withKeyValuesArray: (resultDic.value as! NSDictionary).object(forKey: "session_list"))
                var sessions:[ShowSessionModel] = []
                for session in sessionList!{
                    sessions.append(ShowSessionModel.init(fromDictionary: session as! NSDictionary))
                }
                model.sessionList = sessions
                self.genderTicketShowModel(ticketShow: model)
                if (sessions[0].ticketList.count > 0) {
                    let controllerVC = MyTicketPutUpViewController()
                    controllerVC.viewModel.ticketShowModel = model
                    controllerVC.viewModel.ticketSellCount = MySellViewModel.TicketShowModelSellCount(model)
                    controllerVC.viewModel.ticketSoldCount = MySellViewModel.TicketShowModelSoldCount(model)
                    let priceModel = MySellViewModel.sellManagerMinMaxPrice(model)
                    var ticketMuch = ""
                    if priceModel.minPrice != priceModel.maxPrice {
                        ticketMuch = "\(priceModel.minPrice)-\(priceModel.maxPrice)"
                    }else{
                        ticketMuch = "\(priceModel.minPrice)"
                    }
                    controllerVC.viewModel.ticketSoldMuch = ticketMuch
                    controllerVC.viewModel.ticketSession = MySellViewModel.TicketShowModelSession(model)
                    NavigationPushView(self.controller, toConroller: controllerVC)
                }else{
                    self.pushMySellConfirmVC(model)
                }
                
            }
        }
    }
    
    func pushMySellConfirmVC(_ model:TicketShowModel){
        let controllerVC = MySellConfimViewController()
        controllerVC.viewModel.model = model
        controllerVC.viewModel.isChange = false
        controllerVC.viewModel.isSellTicketView = true
        controllerVC.viewModel.setUpViewModel()
        NavigationPushView(self.controller, toConroller: controllerVC)
    }
    
    func genderTicketShowModel(ticketShow:TicketShowModel){
        var ticketList:[TicketList] = []
        for ticket in ticketShow.sessionList[0].ticketList {
            if ticket.remainCount != 0 {
                ticketList.append(ticket)
            }
        }
        ticketShow.sessionList[0].ticketList = ticketList
    }
}
