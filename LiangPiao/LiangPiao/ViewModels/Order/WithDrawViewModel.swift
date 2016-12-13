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
        let parameters = ["alipay_account":form.aliPayCount,"alipay_name":form.aliPayName,"amount":form.amount]
//        let parameters = ["alipay_account":"18363899723","alipay_name":"张德全","amount":0.01]
        BaseNetWorke.sharedInstance.postUrlWithString(WallWithDraw, parameters: parameters).subscribeNext { (resultDic) in
            print(resultDic)
            NavigationPushView(self.controller, toConroller: WithDrawStatusViewController())
        }
    }
}
