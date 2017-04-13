//
//  WithDreaViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 12/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class WithDreaViewModel: NSObject {

    let cellTitleStrs = ["支付宝账户","提现金额"]
    override init() {
        
    }
    
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        return 1
    }
    
    func cellTitle(_ indexPath:IndexPath) -> String {
        return cellTitleStrs[indexPath.row + 1]
    }
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        if indexPath.section == 0 {
            return 258
        }
        return 49
    }
}
