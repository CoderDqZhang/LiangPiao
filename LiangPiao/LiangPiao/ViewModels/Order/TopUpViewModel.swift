//
//  TopUpViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

typealias UpdateMyWall = (_ model:MyWallModel) -> Void
typealias UpdateMySellConfirm = (_ blance:Int) -> Void


//1是支付宝 2是微信 3是小程序的微信
class TopUpFrom : NSObject {
    var amount: String!
    var pay_type : Int!
}

class TopUpViewModel: NSObject {

    let titleCellHeight = [[100,67,67],[49]]
    var topUpForm:TopUpFrom = TopUpFrom()
    var model:PayUrl!
    var myWall:MyWallModel!
    var updateMyWall:UpdateMyWall!
    var controller:TopUpViewController!
    var topUpNumber:String?
    var updateMySellConfirm:UpdateMySellConfirm!
    
    override init() {
        super.init()
        topUpForm.pay_type = !WXApi.isWXAppInstalled() ? 1 : 2
        NotificationCenter.default.addObserver(self, selector: #selector(TopUpViewModel.paySuccess(_:)), name: NSNotification.Name(rawValue: UserTopUpWall), object: nil)
    }
    
    func paySuccess(_ object:Foundation.Notification){
        if Int(object.object as! String) == 3 {
            if updateMyWall != nil {
                self.myWall.balance = self.myWall.balance + Int(Float(self.topUpForm.amount)! * 100)
                self.updateMyWall(self.myWall)
                self.controller.navigationController?.popViewController(animated: true)
            }else if updateMySellConfirm != nil {
                
                self.updateMySellConfirm(Int(Float(self.topUpForm.amount)! * 100))
                self.controller.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    deinit {
        
    }
    
    func numberOfSection() ->Int {
        return 2
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        switch section {
        case 0:
            if !WXApi.isWXAppInstalled() {
                return 2
            }
            return 3
        default:
            return 1
        }
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, controller:TopUpViewController) {
        if indexPath.section == 0 && indexPath.row != 0 {
            if !WXApi.isWXAppInstalled() {
                topUpForm.pay_type = 1
            }else{
                if indexPath.row == 1 {
                    topUpForm.pay_type = 2
                }else{
                    topUpForm.pay_type = 1
                }
            }
            for index in 1...self.numbrOfRowInSection(0) - 1 {
                let cell = controller.tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! TopUpTypeTableViewCell
                if index == indexPath.row {
                    cell.updataSelectImage(true)
                }else{
                    cell.updataSelectImage(false)
                }
            }
        }else if indexPath.section == 1 {
            
        }
    }
    
    
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        return CGFloat(titleCellHeight[indexPath.section][indexPath.row])
    }
    
    func tableViewTopUpTypeTableViewCell(_ cell:TopUpTypeTableViewCell, indexPath:IndexPath){
        if WXApi.isWXAppInstalled() {
            switch indexPath.row {
            case 1:
                cell.setData(UIImage.init(named: "Icon_Wxpay")!, title: "微信支付", detail: "亿万用户的选择，更快更安全", isSelect: true)
            default:
                cell.setData(UIImage.init(named: "Icon_Alipay")!, title: "支付宝", detail: "推荐支付宝用户使用", isSelect: false)
                cell.hiderLineLabel()
            }
        }else{
            cell.setData(UIImage.init(named: "Icon_Alipay")!, title: "支付宝", detail: "推荐支付宝用户使用", isSelect: true)
            cell.hiderLineLabel()
        }
    }
    
    func requestTopUp(){
        let parameters = ["amount":self.topUpForm.amount,"pay_type":self.topUpForm.pay_type] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(TopUpUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if (!resultDic.isCompleted) {
                self.model = PayUrl.init(fromDictionary: resultDic.value as! NSDictionary)
                self.requestPay(self.model)
            }
        }
    }
    
    func requestPay(_ model:PayUrl){
        if self.topUpForm.pay_type == 1 {
            if model.alipay == "" {
                MainThreadAlertShow("获取支付链接错误", view: KWINDOWDS())
                return
            }
            AlipaySDK.defaultService().payOrder(model.alipay, fromScheme: "LiangPiaoAlipay") { (resultDic) in
                print("resultDic")
            }
        }else{
            if model.wxpay == nil {
                MainThreadAlertShow("获取支付链接错误", view: KWINDOWDS())
                return
            }
            let request = PayReq()
            request.prepayId = model.wxpay.prepayid
            request.partnerId = model.wxpay.partnerid
            request.package = model.wxpay.packageField
            request.nonceStr = model.wxpay.noncestr
            request.timeStamp = UInt32(model.wxpay.timestamp)!
            request.sign = model.wxpay.sign
            WXApi.send(request)
        }
    }
}
