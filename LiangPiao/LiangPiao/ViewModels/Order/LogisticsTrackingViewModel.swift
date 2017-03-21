//
//  LogisticsTrackingViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class LogisticsTrackingViewModel: NSObject {
    var controller:LogisticsTrackingViewController!
    var model:OrderList!
    var deverliyModel:DeverliyModel!
    override init() {
        
    }

    
    func controllerTitle() -> String {
        return "物流追踪"
    }
    
    func tableViewNumberRowInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 1
        default:
            return self.deverliyModel.traces.count
        }
    }
    
    func estimatedHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 124
        default:
            return 82
        }
    }
    
    func tableViewHeightForRowAtIndexPath(tableView:UITableView, indexPath:NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return tableView.fd_heightForCellWithIdentifier("UserAddressTableViewCellLogis", configuration: { (cell) in
                self.configCellReviceCell(cell as! UserAddressTableViewCell, indexPath: indexPath)
            })
        default:
            return tableView.fd_heightForCellWithIdentifier("DeverliyTypeTableViewCell", configuration: { (cell) in
                self.configCellDeverliyTypeTableViewCell(cell as! DeverliyTypeTableViewCell, indexPath: indexPath)
            })
        }
    }
    
    func configCellDeverliyTypeTableViewCell(cell:DeverliyTypeTableViewCell, indexPath:NSIndexPath) {
        let type:DeverliyTypeTableViewCellType = indexPath.row == 0 ? .Doing : indexPath.row < self.deverliyModel.traces.count ? .Done : .None
        cell.setUpData(self.deverliyModel.traces[indexPath.row], type: type)
    }
    
    func tableViewHeiFootView(tableView:UITableView, section:Int) ->CGFloat{
        return 10
    }
    
    func configCellReviceCell(cell:UserAddressTableViewCell, indexPath:NSIndexPath) {
        cell.setUpData(self.model, info: "由 \(self.userAddressInfoTitle()) 负责承运")
    }
    
    func tableViewCellUserAddressTableViewCell(cell:UserAddressTableViewCell, indexPath:NSIndexPath){
        self.configCellReviceCell(cell, indexPath: indexPath)
    }
    
    func tableViewDeverliyTypeTableViewCell(cell:DeverliyTypeTableViewCell, indexPath:NSIndexPath) {
        self.configCellDeverliyTypeTableViewCell(cell, indexPath: indexPath)
    }
    
    func userAddressInfoTitle() ->String {
        var str = ""
        let keys = deverliyDic.allKeys
        for key in keys {
            if deverliyDic[key as! String] as! String == self.deverliyModel.shipperCode {
                str = key as! String
                break
            }
        }
        return str
    }
}

