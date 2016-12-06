//
//  TopUpViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TopUpViewModel: NSObject {

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
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        return 51
    }
}
