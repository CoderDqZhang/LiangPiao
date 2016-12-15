//
//  MySellConfimViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellConfimViewModel: NSObject {
    
    var controller:MySellConfimViewController!
    var tickeListView:GloableTitleList!
    
    override init() {
        super.init()
        self.setUpView()
    }
    
    func setUpView(){
        tickeListView = GloableTitleList.init(frame: CGRect.init(x: 15, y: 62, width: SCREENWIDTH - 30, height: 0), title: ["80","280","380","680","980","800（400*2）","800","980"])
        tickeListView.frame = CGRect.init(x: 15, y: 62, width: SCREENWIDTH - 30, height: tickeListView.maxHeight)
        tickeListView.gloableTitleListClouse = { title, index in
            print("\(title) \(index)")
        }
    }
    
    func tableViewHeightForFooterInSection(section:Int) -> CGFloat{
        return 10
        
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return controller.tableView.fd_heightForCellWithIdentifier("MySellConfimHeaderTableViewCell", configuration: { (cell) in
                self.setConfigHeaderCell(cell as! MySellConfimHeaderTableViewCell, indexPath: indexPath)
            })
        case 1:
            return tickeListView.maxHeight + 78
        case 2:
            return 105
        default:
            return 173
        }
        
    }
    
    func tableViewDidSelect(indexPath:NSIndexPath) {
        
    }
    
    func tableViewNumberOfRowsInSection(section:Int) -> Int{
        return 4
    }
    
    func tableViewCellGloabTitleNumberCountTableViewCell(cell:GloabTitleNumberCountTableViewCell, indexPath:NSIndexPath) {
        cell.setText("售卖数量", textFieldText: "1")
    }
    
    func setConfigHeaderCell(cell:MySellConfimHeaderTableViewCell, indexPath:NSIndexPath) {
        
    }
    
    
    func tableViewMySellConfimHeaderTableViewCell(cell:MySellConfimHeaderTableViewCell, indexPath:NSIndexPath) {
        self.setConfigHeaderCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellMySellTicketTableViewCell(cell:MySellTicketTableViewCell, indexPath:NSIndexPath) {
        cell.contentView.addSubview(tickeListView)
    }
    
    
    func tableViewGloabTitleAndDetailImageCell(cell:GloabTitleAndDetailImageCell, indexPath:NSIndexPath) {
        switch indexPath.row {
        case 0:
            cell.setData("出售方式", detail: "请选择")
        case 1:
            cell.setData("选择区域", detail: "请选择")
        default:
            cell.setData("配送方式", detail: "请选择")
        }
    }
    
    func tableViewMySellServiceTableViewCell(cell:MySellServiceTableViewCell, indexPath:NSIndexPath) {
        switch indexPath.section {
        case 2:
            cell.setData("交易服务费：00.00 元", servicemuch: "结算总价：00.00 元", sevicep: "第三方支付交易手续费1%\n订单票款结算金额将于演出结束后24小时内转入账户钱包中", type: 0)
        default:
            cell.setData("余额：00.00 元", servicemuch: "押金：50.00 元", sevicep: "保证金将于订单完成后直接返还至账户钱包中，挂单、删除或下架后押金亦退还至钱包中", type: 1)
        }
    }

}
