//
//  TopUpViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit


class TopUpViewModel: NSObject {

    let titleCellHeight = [[100,67,67],[49]]
    override init() {
        
    }
    
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        switch section {
        case 0:
            if !WXApi.isWXAppInstalled() {
                return 2
            }
            return 3
        default:
            return 1
        }
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, controller:TopUpViewController) {
        if indexPath.section == 0 && indexPath.row != 0 {
            for index in 1...self.numbrOfRowInSection(0) - 1 {
                let cell = controller.tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! TopUpTypeTableViewCell
                if index == indexPath.row {
                    cell.updataSelectImage(true)
                }else{
                    cell.updataSelectImage(false)
                }
            }
        }
    }
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        return CGFloat(titleCellHeight[indexPath.section][indexPath.row])
    }
    
    func tableViewTopUpTypeTableViewCell(_ cell:TopUpTypeTableViewCell, indexPath:IndexPath){
        if WXApi.isWXAppInstalled() {
            switch indexPath.row {
            case 1:
                cell.setData(UIImage.init(named: "Icon_Wxpay")!, title: "微信支付", detail: "亿万用户的选择，更快更安全", isSelect: true)
            default:
                cell.setData(UIImage.init(named: "Icon_Alipay")!, title: "支付宝", detail: "推荐支付宝用户使用", isSelect: false)
                cell.hiderLineLabel()
            }
        }else{
            cell.setData(UIImage.init(named: "Icon_Alipay")!, title: "支付宝", detail: "推荐支付宝用户使用", isSelect: true)
            cell.hiderLineLabel()
        }
    }
}
