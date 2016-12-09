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
    
    let tableViewHeight = [[110,97,97,109],[55,55,55,55,55],[114],[114]]
    let numberOfRowInSection = [4,5,1,1]
    override init() {
        
    }
    
    func tableViewHeightForFooterInSection(section:Int) -> CGFloat{
        return 10
        
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat {
        return CGFloat(tableViewHeight[indexPath.section][indexPath.row])
    }
    
    func tableViewDidSelect(indexPath:NSIndexPath) {
        
    }
    
    func tableViewNumberOfRowsInSection(section:Int) -> Int{
        return numberOfRowInSection[section]
    }
    
    func tableViewCellGloabTitleNumberCountTableViewCell(cell:GloabTitleNumberCountTableViewCell, indexPath:NSIndexPath) {
        switch indexPath.row {
        case 1:
            cell.setText("售卖数量", textFieldText: "1")
        default:
            cell.setText("售卖价格", textFieldText: "220.00")
        }
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
