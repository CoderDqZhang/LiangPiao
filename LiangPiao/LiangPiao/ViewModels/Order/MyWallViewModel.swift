//
//  MyWallViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyWallViewModel: NSObject {

    var model:MyWallModel!
    var controller:MyWalletViewController!
    override init() {
        super.init()
//        NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue: BlanceNumberChange)).observe { (object) in
//            self.requestMyWall()
//        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: BlanceNumberChange)
    }
    
    func messageTitle() -> String{
        return "订单票款将于对方确认收货后立即结算至钱包账户\n 所有交易免佣金，仅含1%第三方支付平台交易手续费"
    }
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        switch indexPath.row {
        case 0:
            return 190
        default:
            return 80
        }
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        return 2
    }
    
    func numberOfSection() -> Int{
        return 1
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, controller:MyWalletViewController) {
        
    }
    
    func tableViewCellMyWallHeaderTableViewCell(_ cell:MyWallHeaderTableViewCell){
        if self.model != nil {
            if self.model.balance == 0 {
                cell.setBlance("0.00")
            }else{
            
                let str = "\(self.model.balance)".muchType("\((self.model.balance)!)")
                cell.setBlance("\(str)")
            }
        }
        
    }
    
    func tableViewCellMyWallToolsTableViewCell(_ cell:MyWallToolsTableViewCell){
        if self.model != nil {
            var blance:String = "0.00"
            var pendingBalance = "0.00"
            var deposit = "0.00"
            if self.model.balance != 0 {
                blance = "\(self.model.balance)".muchType("\((self.model.balance)!)")
            }
            if self.model.pendingBalance != 0 {
                pendingBalance = "\(self.model.pendingBalance)".muchType("\((self.model.pendingBalance)!)")
            }
            if self.model.deposit != 0 {
                deposit = "\(self.model.deposit)".muchType("\((self.model.deposit)!)")
            }
            cell.setData(blance, freeze: deposit, preString: pendingBalance)
        }
    }
    
    func requestMyWall(){
        BaseNetWorke.sharedInstance.getUrlWithString(WallBlance, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = MyWallModel.init(fromDictionary: resultDic.value as! NSDictionary)
                self.controller.tableView.reloadData()
            }
        }
    }
}
