//
//  MineViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MineViewModel: NSObject {

    override init() {
        
    }
    
    func numberOfSection() ->Int {
        return 1
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        return 5
    }
    
    func tableViewHeightForRow(row:Int) ->CGFloat {
        switch row {
        case 0:
            return 255
        case 4:
            return SCREENHEIGHT - 282 - 164
        default:
            return 47
        }
    }
    
    func cellTitle(indexPathRow:Int) -> String {
        switch indexPathRow {
        case 1:
            return "想看的演出"
        case 2:
            return "地址管理"
        case 3:
            return "设置"
        default:
            return ""
        }
    }
    
    func cellImage(indexPathRow:Int) -> UIImage {
        switch indexPathRow {
        case 1:
            return UIImage.init(named: "Icon_Favorite")!
        case 2:
            return UIImage.init(named: "Icon_Address")!
        case 3:
            return UIImage.init(named: "Icon_Settings")!
        default:
            return UIImage.init(named: "Icon_Settings")!
        }
    }
}
