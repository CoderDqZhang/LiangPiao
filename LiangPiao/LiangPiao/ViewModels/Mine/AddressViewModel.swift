//
//  AddressViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class AddressViewModel: NSObject {
    
    override init() {
        
    }
    
    func configCell(cell:AddressTableViewCell,indexPath:NSIndexPath) {
        if indexPath.row == 0 {
            cell.setData("冉灿    19932434234", address: "朝阳区香河园小区西坝河中里35号楼 UPlan Coffee 二层207", isNomal: true, isSelect: true)
        }else if indexPath.row == 1 {
            cell.setData("冉灿    19932434234", address: "宣武区大栅栏大街39号(大观楼电影院对面) ", isNomal: false, isSelect: false)
        }else{
            cell.setData("Randy RAN   18602035508", address: "Placerville OH State, Meadow Street, Vale base 86 95916-2621", isNomal: false, isSelect: false)
        }
    }
    
    func tableViewHeightForRow(tableView:UITableView, indexPath:NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier("AddressTableViewCell", configuration: { (cell) in
            self.configCell(cell as! AddressTableViewCell, indexPath: indexPath)
        })
    }

    func tableViewDidSelectIndexPath(tableView:UITableView, indexPath:NSIndexPath) {
        for i in 0...tableView.numberOfRowsInSection(0) - 1 {
            if indexPath.row == i {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! AddressTableViewCell

               cell.updateSelectImage(true)
            }else{
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: indexPath.section)) as! AddressTableViewCell
               cell.updateSelectImage(false)
            }
        }
    }
    
    
    func tableViewNumberRowInSection(section:Int) -> Int {
        return 3
    }
}

class AddAddressViewModel: NSObject {
    override init() {
        
    }
    
    func tableViewConfigCell(indexPath:NSIndexPath)-> String{
        switch indexPath.row{
        case 0:
            return "收货人姓名"
        case 1:
            return "联系电话"
        default:
            return "地区"
        }
    }
    
    func configCell(cell:AddressTableViewCell,indexPath:NSIndexPath) {
        if indexPath.row == 0 {
            cell.setData("冉灿    19932434234", address: "朝阳区香河园小区西坝河中里35号楼 UPlan Coffee 二层207", isNomal: true, isSelect: true)
        }else if indexPath.row == 1 {
            cell.setData("冉灿    19932434234", address: "宣武区大栅栏大街39号(大观楼电影院对面) ", isNomal: false, isSelect: false)
        }else{
            cell.setData("Randy RAN   18602035508", address: "Placerville OH State, Meadow Street, Vale base 86 95916-2621", isNomal: false, isSelect: false)
        }
    }
}
