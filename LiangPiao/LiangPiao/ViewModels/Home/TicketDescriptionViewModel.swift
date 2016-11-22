//
//  TicketDescriptionViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 21/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketDescriptionViewModel: NSObject {

    override init() {
        super.init()
    }
    
    func tableViewHeight(row:Int) -> CGFloat
    {
        switch row {
        case 0:
            return 188
        case 1:
            return 80
        case 2:
            return 180
        case 3:
            return 42
        default:
            return 60
        }
    }
}
