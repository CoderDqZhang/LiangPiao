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
    }
    
    func messageTitle() -> String{
        return "良票根据您的交易情况收取佣金\n每日前 10 张成交订单，佣金免费\n超过 10 单，每张收取订单金额 5% 作为佣金"
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
            
                let blance = Double("\(self.model.balance).00")! / 100.00
                
                cell.setBlance("\(blance)")
            }
        }
        
    }
    
    func tableViewCellMyWallToolsTableViewCell(cell:MyWallToolsTableViewCell){
        if self.model != nil {
            var blance:String = "0.00"
            var pendingBalance = "0.00"
            if self.model.balance != 0 {
                blance = String(Double(Double("\(self.model.balance).00")! / 100.00))
            }
            if self.model.pendingBalance != 0 {
                pendingBalance = String(Double(Double("\(self.model.pendingBalance).00")! / 100.00))
            }
            cell.setData(blance, freeze: "0.00", preString: pendingBalance)
        }
    }
    
    func requestMyWall(){
        BaseNetWorke.sharedInstance.getUrlWithString(WallBlance, parameters: nil).subscribeNext { (resultDic) in
            self.model = MyWallModel.init(fromDictionary: resultDic as! NSDictionary)
            self.controller.tableView.reloadData()
        }
    }
}
