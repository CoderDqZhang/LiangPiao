//
//  FavoriteViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 01/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class FavoritesViewModel: NSObject {
    
    var model:FavorityModel!
    override init() {
        
    }
    
    func numberOfSectionsInTableView() -> Int{
        return 2
    }
    
    func numberOfRowsInSection(section:Int) ->Int {
        if model != nil {
            return model.items.count
        }
        return 0
    }
    
    func tableViewHeightForFooterInSection(section:Int) -> CGFloat {
        return 0.0001
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat
    {
        return 140
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath, controller:FavoriteViewController) {
         let homeTick = model.items[indexPath.row]
        if homeTick.show.sessionCount == 1 {
            let controllerVC = TicketDescriptionViewController()
            controllerVC.viewModel.ticketModel = homeTick.show
            NavigationPushView(controller, toConroller: controllerVC)
        }else{
            let controllerVC = TicketSceneViewController()
            controllerVC.viewModel.model = homeTick.show
            NavigationPushView(controller, toConroller: controllerVC)
        }
    }
    
    func cellData(cell:RecommendTableViewCell, indexPath:NSIndexPath) {
        if model != nil {
            let homeTick = model.items[indexPath.row]
            cell.setData(homeTick.show)
        }
    }
    
    func requestFavoriteTicket(controller:FavoriteViewController, isNext:Bool){
        var url = ""
        if isNext {
            url = "\(TicketFavorite)?page=\(model.nextPage)"
        }else{
            url = "\(TicketFavorite)"
        }
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            if isNext {
                let tempModel = FavorityModel.init(fromDictionary: resultDic as! NSDictionary)
                self.model.hasNext = tempModel.hasNext
                self.model.items.appendContentsOf(tempModel.items)
                controller.tableView.reloadData()
            }else{
                self.model = FavorityModel.init(fromDictionary: resultDic as! NSDictionary)
                controller.tableView.reloadData()
                if controller.tableView.mj_footer != nil && self.model.hasNext == true {
                    controller.setUpLoadMoreData()
                }
                if controller.tableView.mj_header != nil {
                    controller.tableView.mj_header.endRefreshing()
                }
            }
        }
    }
}
