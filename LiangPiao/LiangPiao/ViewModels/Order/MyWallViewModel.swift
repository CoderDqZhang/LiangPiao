//
//  MyWallViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class MyWallViewModel: NSObject {

    var model:MyWallModel!
    var controller:MyWalletViewController!
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().rac_addObserverForName(BlanceNumberChange, object: nil).subscribeNext { (object) in
            self.requestMyWall()
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: BlanceNumberChange)
    }
    
    func messageTitle() -> String{
        return "演出结束后第二天，完成票款结算\n 所有交易免佣金，仅含1%第三方支付平台交易手续费"
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        switch indexPath.row {
        case 0:
            return 190
        default:
            return 80
        }
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        return 2
    }
    
    func numberOfSection() -> Int{
        return 1
    }
    
    func tableViewDidSelect(indexPath:NSIndexPath, controller:MyWalletViewController) {
        
    }
    
    func tableViewCellMyWallHeaderTableViewCell(cell:MyWallHeaderTableViewCell){
        if self.model != nil {
            if self.model.balance == 0 {
                cell.setBlance("0.00")
            }else{
            
                let str = "\(self.model.balance)".muchType("\(self.model.balance)")
                cell.setBlance("\(str)")
            }
        }
        
    }
    
    func tableViewCellMyWallToolsTableViewCell(cell:MyWallToolsTableViewCell){
        if self.model != nil {
            var blance:String = "0.00"
            var pendingBalance = "0.00"
            var deposit = "0.00"
            if self.model.balance != 0 {
                blance = "\(self.model.balance)".muchType("\(self.model.balance)")
            }
            if self.model.pendingBalance != 0 {
                pendingBalance = "\(self.model.pendingBalance)".muchType("\(self.model.pendingBalance)")
            }
            if self.model.deposit != 0 {
                deposit = "\(self.model.deposit)".muchType("\(self.model.deposit)")
            }
            cell.setData(blance, freeze: deposit, preString: pendingBalance)
        }
    }
    
    func requestMyWall(){
        BaseNetWorke.sharedInstance.getUrlWithString(WallBlance, parameters: nil).subscribeNext { (resultDic) in
            self.model = MyWallModel.init(fromDictionary: resultDic as! NSDictionary)
            self.controller.tableView.reloadData()
        }
    }
}
