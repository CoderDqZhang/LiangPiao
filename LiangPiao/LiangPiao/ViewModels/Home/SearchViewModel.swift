//
//  SearchViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 01/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum SearchType {
    case ticketShowModel
    case ticketSell
    case ticketShowHistory
    case ticketSellHistory
}
typealias SearchViewModelClouse = () ->Void

class SearchViewModel: NSObject {

    var searchModel:RecommentTickes!
    var sellSearchModel:RecommentTickes!
    var controller:HomeViewController!
    var controllerS:SellTicketsViewController!
    var searchViewModelClouse:SearchViewModelClouse!
    var searchType:SearchType = .ticketShowHistory
    var searchStr:String = ""
    var searchHistory:SearchHistory!
    var tableView:UITableView!
    
    fileprivate override init() {
        super.init()
        self.loadSearchHistory()
    }
    
    func loadSearchHistory(){
        searchHistory = SearchHistory.shareInstance.loadData()
    }
    
    func saveSearchHistory(){
        
        if searchType == .ticketShowModel {
            var strings  = searchHistory.showSearchHistory
            strings.append(self.searchStr)
            searchHistory.showSearchHistory = strings
        }else if searchType == .ticketSell {
            var strings  = searchHistory.sellSearchHistory
            strings.append(self.searchStr)
            searchHistory.sellSearchHistory = strings
        }
        SearchHistory.shareInstance.saveData(searchHistory: searchHistory)
    }
    
    func emptyPlachTextTitle() -> String {
        if searchType == .ticketShowModel {
            return "搜索你关注的演出"
        }
        return "搜索想转卖的演出"
    }
    
    static let shareInstance = SearchViewModel()
    // MARK: SearchTableView
    func searchTableNumberOfSectionsInTableView() -> Int{
        return 1
    }
    
    func searchTableNumberOfRowsInSection(_ section:Int) ->Int {
        if searchType == .ticketShowModel {
            if searchModel != nil {
                return searchModel.showList.count
            }
        }else if searchType == .ticketSell {
            if sellSearchModel != nil {
                return sellSearchModel.showList.count
            }
        }else if searchType == .ticketShowHistory {
            
            return searchHistory.showSearchHistory.count
        }
        return searchHistory.sellSearchHistory.count
    }
    
    func searchTableTableViewHeightForFooterInSection(_ section:Int) -> CGFloat {
        return 0.0001
    }
    
    func searchTablaTableViewHeightForHeaderInSection(_ section:Int) -> CGFloat {
        if searchType == .ticketShowModel || searchType == .ticketSell{
            return 0.0001
        }
        return 0.0001
    }
    
    func searchTableTableViewHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat
    {
        if searchType == .ticketShowModel || searchType == .ticketSell{
            return 140
        }
        return 49
    }
    
    func searchTablaTableViewDidSelectRowAtIndexPath(_ indexPath:IndexPath ) {
        self.saveSearchHistory()
        if searchType == .ticketShowModel {
            let searchTicke = searchModel.showList[indexPath.row]
            GloableSetEvent("HomeSearch", lable: "HomeSearch", parameters: searchTicke.toDictionary())
            self.controller.view.endEditing(true)
            if searchTicke.sessionCount == 1 {
                let controllerVC = TicketDescriptionViewController()
                controllerVC.viewModel.ticketModel = searchTicke
                NavigationPushView(controller, toConroller: controllerVC)
            }else{
                let controllerVC = TicketSceneViewController()
                controllerVC.viewModel.model = searchTicke
                NavigationPushView(controller, toConroller: controllerVC)
            }
            
        }else if searchType == .ticketSell {
            if UserInfoModel.isLoggedIn() {
                GloableSetEvent("SellSearch", lable: "SellSearch", parameters: sellSearchModel.showList[indexPath.row].toDictionary())
                if UserInfoModel.shareInstance().role == "supplier" {
                    let model = sellSearchModel.showList[indexPath.row]
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
                    UIAlertController.shwoAlertControl(controller, style: .alert, title: "您还非商家哦，可联系客服400-873-8011", message: nil, cancel: "取消", doneTitle: "联系客服", cancelAction: {
                        
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
    
    func searchTableCellData(_ cell:RecommendTableViewCell, indexPath:IndexPath) {
        if searchType == .ticketShowModel {
            if searchModel != nil && searchModel.showList != nil {
                let searchTicke = searchModel.showList[indexPath.row]
                cell.setData(searchTicke)
            }
        }else if searchType == .ticketSell{
            if sellSearchModel != nil && sellSearchModel.showList != nil{
                let searchTicke = sellSearchModel.showList[indexPath.row]
                cell.setData(searchTicke)
            }
        }else{
            print("显示搜索历史")
        }
    }
    
    func searchHistoryCell(_ cell:SearchHistoryTableViewCell, indexPath:IndexPath) {
        if searchType == .ticketShowHistory {
            cell.setData(self.searchHistory.showSearchHistory[indexPath.row])
        }else{
            cell.setData(self.searchHistory.sellSearchHistory[indexPath.row])
        }
        cell.closeBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            if self.searchType == .ticketShowHistory {
                self.searchHistory.showSearchHistory.remove(at: indexPath.row)
            }else if self.searchType == .ticketSellHistory {
                self.searchHistory.sellSearchHistory.remove(at: indexPath.row)
            }
            SearchHistory.shareInstance.saveData(searchHistory: self.searchHistory)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func searchTableCellDatas(_ cell:SellRecommondTableViewCell, indexPath:IndexPath) {
        if sellSearchModel != nil {
            let searchTicke = sellSearchModel.showList[indexPath.row]
            cell.setData(searchTicke)
        }
    }
    
    func requestSearchTicket(_ searchText:String, searchTable:GlobalSearchTableView) {
        
        var url = ""
        let str = searchText.addEncoding(searchText)
        self.searchStr = str!
        if self.searchType == .ticketShowModel || self.searchType == .ticketShowHistory{
            if searchText == "" {
                self.searchType = .ticketShowHistory
                self.loadSearchHistory()
                searchTable.tableView.reloadData()
                return
            }else{
                self.searchType = .ticketShowModel
                self.loadSearchHistory()
                searchTable.tableView.reloadData()
            }
            url = "\(TicketSearchUrl)?kw=\((str)!)"
        }else if self.searchType == .ticketSell || self.searchType == .ticketSellHistory{
            if searchText == "" {
                self.searchType = .ticketSellHistory
                searchTable.tableView.reloadData()
                return
            }else{
                self.searchType = .ticketSell
            }
            url = "\(SearchSellURl)?kw=\((str)!)"
        }
        if searchText != "" {
            BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
                if !resultDic.isCompleted {
                    if self.searchType == .ticketShowModel {
                        self.searchModel = RecommentTickes.init(fromDictionary: resultDic.value as! NSDictionary)
                    }else{
                        self.sellSearchModel = RecommentTickes.init(fromDictionary: resultDic.value as! NSDictionary)
                    }
                    searchTable.tableView.reloadData()
                }
            }
        }
    }
    
}
