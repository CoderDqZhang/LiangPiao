//
//  SearchViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 01/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SearchViewModel: NSObject {

    var searchModel:RecommentTickes!
    var controller:HomeViewController!
    
    private override init() {
        
    }
    static let shareInstance = SearchViewModel()
    // MARK: SearchTableView
    func searchTableNumberOfSectionsInTableView() -> Int{
        return 1
    }
    
    func searchTableNumberOfRowsInSection(section:Int) ->Int {
        if searchModel != nil {
            return searchModel.showList.count
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
    }
    
    func searchTableCellData(cell:RecommendTableViewCell, indexPath:NSIndexPath) {
        if searchModel != nil {
            let searchTicke = searchModel.showList[indexPath.row]
            cell.setData(searchTicke)
        }
    }
    
    
    
    func requestSearchTicket(searchText:String, searchTable:GlobalSearchTableView) {
        let url = "\(TicketSearchUrl)?kw=\(searchText)"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            self.searchModel = RecommentTickes.init(fromDictionary: resultDic as! NSDictionary)
            searchTable.tableView.reloadData()
        }
    }
}
