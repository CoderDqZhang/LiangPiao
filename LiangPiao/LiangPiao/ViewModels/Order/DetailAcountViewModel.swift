//
//  DetailAcountViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class DetailAcountViewModel: NSObject {

    var model:MyWallHistoryModel!
    var controller:DetailAccountViewController!
    override init() {
        
    }
    
    func numberOfSection() ->Int {
        return 1
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        if model != nil {
            return model.hisList.count
        }
        return 0
    }
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        return 65
    }
    
    func tableViewDetailAcountTableViewCell(_ cell:DetailAcountTableViewCell, indexPath:IndexPath) {
        cell.setData(model.hisList[indexPath.row])
    }
    
    func requestDetailAcount(_ isNext:Bool){
        var url = ""
        if isNext {
            if model.hasNext == false {
                self.controller.tableView.mj_footer.endRefreshing()
                return
            }
            url = "\(WallHistory)?page=\((model.nextPage)!)"
        }else{
            url = WallHistory
        }
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.controller.tableView == nil {
                    self.controller.setUpView()
                }
                if isNext {
                    let tempModel =  MyWallHistoryModel.init(fromDictionary: resultDic.value as! NSDictionary)
                    self.model.hasNext = tempModel.hasNext
                    self.model.nextPage = tempModel.nextPage
                    self.model.hisList.append(contentsOf: tempModel.hisList)
                    if (self.model.hasNext != nil) && self.model.hasNext == true {
                        self.controller.tableView.mj_footer.endRefreshing()
                    }else{
                        self.controller.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                }else{
                    self.model =  MyWallHistoryModel.init(fromDictionary: resultDic.value as! NSDictionary)
                    if self.model.hasNext != nil && self.model.hasNext == true {
                        if self.controller.tableView.mj_footer == nil {
                            self.controller.setUpLoadMoreData()
                        }
                    }
                    if self.controller.tableView.mj_header != nil {
                        self.controller.tableView.mj_header.endRefreshing()
                    }
                }
                
                self.controller.tableView.reloadData()
            }
        }
    }
}
