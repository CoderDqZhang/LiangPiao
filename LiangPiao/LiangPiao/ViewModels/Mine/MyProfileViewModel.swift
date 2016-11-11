//
//  MyProfileViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyProfileViewModel: NSObject {
   
    let titleLabel = ["昵称","性别","生日","城市","手机号"]
    override init() {
        
    }
    
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 1
        default:
            return 5
        }
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 48
        }
    }
    
    func cellTitle(indexPath:NSIndexPath) -> String {
        if indexPath.section == 1 {
            return titleLabel[indexPath.row]
        }else{
            return ""
        }
    }
    
    func cellDetail(indexPath:NSIndexPath) -> String {
        if indexPath.section == 1 {
            return titleLabel[indexPath.row]
        }else{
            return ""
        }
    }
    
    func updateCellString(tableView:UITableView ,string:String, tag:NSInteger) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: tag, inSection: 1)) as! GloabTitleAndDetailImageCell
        cell.detailLabel.text = string            
    }
}
