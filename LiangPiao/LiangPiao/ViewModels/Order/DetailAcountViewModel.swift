//
//  DetailAcountViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class DetailAcountViewModel: NSObject {

    override init() {
        
    }
    
    func numberOfSection() ->Int {
        return 1
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        return 5
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        return 65
    }
}
