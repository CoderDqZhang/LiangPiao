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
    
    func tableViewNumberRowInSection(_ section:Int) ->Int {
        switch section {
        case 0:
            return 1
        default:
            return self.deverliyModel.traces.count
        }
    }
    
    func estimatedHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 124
        default:
            return 82
        }
    }
    
    func tableViewHeightForRowAtIndexPath(_ tableView:UITableView, indexPath:IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return tableView.fd_heightForCell(withIdentifier: "LogisticsTableViewCell", configuration: { (cell) in
                self.configCellReviceCell(cell as! LogisticsTableViewCell, indexPath: indexPath)
            })
        default:
            return tableView.fd_heightForCell(withIdentifier: "DeverliyTypeTableViewCell", configuration: { (cell) in
                self.configCellDeverliyTypeTableViewCell(cell as! DeverliyTypeTableViewCell, indexPath: indexPath)
            })
        }
    }
    
    func configCellDeverliyTypeTableViewCell(_ cell:DeverliyTypeTableViewCell, indexPath:IndexPath) {
        let type:DeverliyTypeTableViewCellType = indexPath.row == 0 ? .doing : indexPath.row < self.deverliyModel.traces.count ? .done : .none
        cell.setUpData(self.deverliyModel.traces[indexPath.row], type: type)
    }
    
    func tableViewHeiFootView(_ tableView:UITableView, section:Int) ->CGFloat{
        return 10
    }
    
    func configCellReviceCell(_ cell:LogisticsTableViewCell, indexPath:IndexPath) {
        cell.setUpData(self.deverliyModel, info: "由 \(self.userAddressInfoTitle()) 负责承运")
    }
    
    func tableViewCellUserAddressTableViewCell(_ cell:LogisticsTableViewCell, indexPath:IndexPath){
        self.configCellReviceCell(cell, indexPath: indexPath)
    }
    
    func tableViewDeverliyTypeTableViewCell(_ cell:DeverliyTypeTableViewCell, indexPath:IndexPath) {
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

