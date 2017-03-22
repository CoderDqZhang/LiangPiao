//
//  DeverliyPushViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class DeverliyForm : NSObject {
    var deverliyName:String = "SF"
    var deverliyNum:String = ""
}

typealias ReloadeMyOrderDeatail = (indexPath:NSIndexPath, model:OrderList) -> Void

class DeverliyPushViewModel: NSObject {
    
    var controller:DelivererPushViewController!
    var model:OrderList!
    var deverliyType:ZHPickView!
    var form = DeverliyForm()
    var indexPath:NSIndexPath!
    var reloadeMyOrderDeatail:ReloadeMyOrderDeatail!
    
    override init() {
        
    }
    
    func showDeverliyTypePickerView(){
        if deverliyType == nil {
            deverliyType = ZHPickView(pickviewWithArray: deverliyDic.allKeys, isHaveNavControler: false)
            deverliyType.setPickViewColer(UIColor.whiteColor())
            deverliyType.setPickViewColer(UIColor.whiteColor())
            deverliyType.setTintColor(UIColor.whiteColor())
            deverliyType.tag = 0
            deverliyType.setToolbarTintColor(UIColor.whiteColor())
            deverliyType.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            deverliyType.delegate = self
        }
        
        deverliyType.show()
    }
    
    func controllerTitle() -> String {
        return "发货"
    }
    
    func orderExpressRequest(){
        let url = "\(OrderExpress)/\(model.orderId)/express/"
        let parameters = [
            "express_name":self.form.deverliyName,
            "express_num":self.form.deverliyNum
        ]
        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
            let url = "\(OrderChangeShatus)\(self.model.orderId)/"
            let parameters = ["status":"7"]
            BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
                let tempModel = OrderList.init(fromDictionary: resultDic as! NSDictionary)
                self.model.status = tempModel.status
                self.model.statusDesc = tempModel.statusDesc
                self.model.supplierStatusDesc = tempModel.supplierStatusDesc
                if self.reloadeMyOrderDeatail != nil {
                    self.reloadeMyOrderDeatail(indexPath: self.indexPath, model:self.model)
                }
                self.controller.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func tableViewNumberRowInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 1
        default:
            return 2
        }
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return controller.tableView.fd_heightForCellWithIdentifier("UserAddressTableViewCell", configuration: { (cell) in
                self.configCellReviceCell(cell as! UserAddressTableViewCell, indexPath: indexPath)
            })
        default:
            return 49
        }
    }
    
    func tableViewHeiFootView(tableView:UITableView, section:Int) ->CGFloat{
        return 10
    }
    
    func configCellReviceCell(cell:UserAddressTableViewCell, indexPath:NSIndexPath) {
        cell.setUpData(self.model, info: "配送信息")
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath, controller:DelivererPushViewController) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.showDeverliyTypePickerView()
            }
        }
    }
    
    func tableViewCellUserAddressTableViewCell(cell:UserAddressTableViewCell, indexPath:NSIndexPath){
        self.configCellReviceCell(cell, indexPath: indexPath)
    }
    
    func tableViewGloabTitleAndDetailImageCell(cell:GloabTitleAndDetailImageCell, indexPath:NSIndexPath) {
        cell.setData("物流公司", detail: "顺丰")
    }
    
    func tableViewCellGloabTitleAndTextFieldCell(cell:GloabTitleAndTextFieldCell, indexPath:NSIndexPath) {
        cell.setData("快递单号", plachString: "填写快递单号", textFieldText: "")
        cell.textField.rac_textSignal().subscribeNext { (resultStr) in
            self.form.deverliyNum = resultStr as! String
        }
    }
}

extension DeverliyPushViewModel : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(pickView: ZHPickView!, resultString: String!) {
        let cell = self.controller.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 1)) as! GloabTitleAndDetailImageCell
        cell.setDetailText(resultString)
        form.deverliyName = deverliyDic[resultString] as! String
    }
}
