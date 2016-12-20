//
//  WithDrawViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class WithDrawForm: NSObject {
    var aliPayName:String = ""
    var aliPayCount:String = ""
    var amount:String = ""
}



class WithDrawViewModel: NSObject {

    let cellTitleStrs = ["支付宝账户","支付宝姓名"]
    var form:WithDrawForm = WithDrawForm.init()
    var maxMuch:String!
    var controller:WithDrawViewController!
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
    
    func requestWithDraw(form:WithDrawForm){
        if Double(form.amount) < 50 {
            UIAlertController.shwoAlertControl(self.controller, style: .Alert, title: "单笔提现金额须大于50元哦", message: nil, cancel: "好的", doneTitle: nil, cancelAction: { 
                
                }, doneAction: {
                    
            })
            return
        }
        let parameters = ["alipay_account":form.aliPayCount,"alipay_name":form.aliPayName,"amount":form.amount]        
        BaseNetWorke.sharedInstance.postUrlWithString(WallWithDraw, parameters: parameters).subscribeNext { (resultDic) in
            UserDefaultsSetSynchronize(form.aliPayCount, key: "aliPayCount")
            UserDefaultsSetSynchronize(form.aliPayName, key: "aliPayName")
            let controllerVC = WithDrawStatusViewController()
            controllerVC.name = form.aliPayName
            controllerVC.amount = form.amount
            NavigationPushView(self.controller, toConroller: controllerVC)
        }
    }
}
