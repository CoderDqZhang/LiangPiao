//
//  SearchViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 01/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum SearchType {
    case TicketShowModel
    case TicketSell
}
typealias SearchViewModelClouse = () ->Void

class SearchViewModel: NSObject {

    var searchModel:RecommentTickes!
    var controller:HomeViewController!
    var controllerS:SellTicketsViewController!
    var searchViewModelClouse:SearchViewModelClouse!
    var searchType:SearchType = .TicketShowModel
    
    private override init() {
        
    }
    static let shareInstance = SearchViewModel()
    // MARK: SearchTableView
    func searchTableNumberOfSectionsInTableView() -> Int{
        return 1
    }
    
    func searchTableNumberOfRowsInSection(section:Int) ->Int {
        if searchType == .TicketShowModel {
            if searchModel != nil {
                return searchModel.showList.count
            }
        }else {
            if searchModel != nil {
                return searchModel.showList.count
            }
        }
        
        return 0
    }
    
    func searchTableTableViewHeightForFooterInSection(section:Int) -> CGFloat {
        return 0.0001
    }
    
    func searchTableTableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat
    {
        return 140
    }
    
    func searchTablaTableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath ) {
        if searchType == .TicketShowModel {
            let searchTicke = searchModel.showList[indexPath.row]
            if searchTicke.sessionCount == 1 {
                let controllerVC = TicketDescriptionViewController()
                controllerVC.viewModel.ticketModel = searchTicke
                NavigationPushView(controller, toConroller: controllerVC)
            }else{
                let controllerVC = TicketSceneViewController()
                controllerVC.viewModel.model = searchTicke
                NavigationPushView(controller, toConroller: controllerVC)
            }
        }else {
            if UserInfoModel.isLoggedIn() {
                if UserInfoModel.shareInstance().role == "supplier" {
                    let model = searchModel.showList[indexPath.row]
                    if model.sessionCount != 1 {
                        let controllerVC = TicketSceneViewController()
                        controllerVC.viewModel.model = model
                        controllerVC.viewModel.isSellType = true
                        NavigationPushView(controllerS, toConroller: controllerVC)
                    }else{
                        let controllerVC = MySellConfimViewController()
                        controllerVC.viewModel.model = model
                        controllerVC.viewModel.isChange = false
                        controllerVC.viewModel.setUpViewModel()
                        NavigationPushView(controllerS, toConroller: controllerVC)
                    }
                }else{
                    UIAlertController.shwoAlertControl(controller, style: .Alert, title: "您还非商家哦，可联系客服400-873-8011", message: nil, cancel: "取消", doneTitle: "联系客服", cancelAction: {
                        
                        }, doneAction: {
                            AppCallViewShow(self.controller.view, phone: "400-873-8011")
                    })
                }
            }else{
                NavigationPushView(controllerS, toConroller: LoginViewController())
            }
        }
        
        if searchViewModelClouse != nil {
            searchViewModelClouse()
        }
    }
    
    func searchTableCellData(cell:RecommendTableViewCell, indexPath:NSIndexPath) {
        if searchModel != nil {
            let searchTicke = searchModel.showList[indexPath.row]
            cell.setData(searchTicke)
        }
    }
    
    func searchTableCellDatas(cell:SellRecommondTableViewCell, indexPath:NSIndexPath) {
        if searchModel != nil {
            let searchTicke = searchModel.showList[indexPath.row]
            cell.setData(searchTicke)
        }
    }
    
    func requestSearchTicket(searchText:String, searchTable:GlobalSearchTableView) {
        let str = searchText.addEncoding(searchText)
        let url = "\(TicketSearchUrl)?kw=\((str)!)"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            self.searchModel = RecommentTickes.init(fromDictionary: resultDic as! NSDictionary)
            searchTable.tableView.reloadData()
        }
    }
}
