//
//  MyWallViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyWallViewModel: NSObject {

    override init() {
        super.init()
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
}
