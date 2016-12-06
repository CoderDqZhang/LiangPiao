//
//  WithDrawViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class WithDrawViewModel: NSObject {

    let cellTitleStrs = ["支付宝账户","支付宝姓名"]
    override init() {
        
    }
    
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    func cellTitle(indexPath:NSIndexPath) -> String {
        return cellTitleStrs[indexPath.row]
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        return 49
    }
}
