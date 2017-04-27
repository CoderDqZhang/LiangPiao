//
//  DeverliyPushViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class DeverliyForm : NSObject {
    var deverliyName:String = "SF"
    var deverliyNum:String = ""
    var image:UIImage!
}

typealias ReloadeMyOrderDeatail = (_ indexPath:IndexPath, _ model:OrderList) -> Void

class DeverliyPushViewModel: NSObject {
    
    var controller:DelivererPushViewController!
    var model:OrderList!
    var deverliyType:ZHPickView!
    var form = DeverliyForm()
    var indexPath:IndexPath!
    var isUploadImage:Bool = false
    var reloadeMyOrderDeatail:ReloadeMyOrderDeatail!
    
    override init() {
        
    }
    
    func showDeverliyTypePickerView(){
        if deverliyType == nil {
            deverliyType = ZHPickView(pickviewWith: deverliyDic.allKeys, isHaveNavControler: false)
            deverliyType.setPickViewColer(UIColor.white)
            deverliyType.setPickViewColer(UIColor.white)
            deverliyType.setTintColor(UIColor.white)
            deverliyType.tag = 0
            deverliyType.setToolbarTintColor(UIColor.white)
            deverliyType.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            deverliyType.delegate = self
        }
        
        deverliyType.show()
    }
    
    func uploadImage(image:UIImage) {
        self.form.image = image
        isUploadImage = true
        _ = SaveImageTools.sharedInstance.saveImage("\((self.model.orderId)!).png", image: self.form.image, path: "deverliyPush")
        let cell = self.controller.tableView.cellForRow(at: IndexPath.init(row: 2, section: 1)) as! GloabTitleAndDetailImageCell
        cell.setDetailText("重新上传")
    }
    
    func controllerTitle() -> String {
        return "发货"
    }
    
    func orderExpressRequest(){
        let url = "\(OrderExpress)/\((model.orderId)!)/express/"
        let fileUrl = SaveImageTools.sharedInstance.getCachesDirectory("\((self.model.orderId)!).png", path: "deverliyPush")
        let parameters = [
            "express_name":self.form.deverliyName,
            "express_num":self.form.deverliyNum,
        ]
        
        let images = ["photo":fileUrl]
        
        BaseNetWorke.sharedInstance.uploadDataFile(url, parameters: parameters as NSDictionary, images: images as NSDictionary).observe { (resultDic) in
            if !resultDic.isCompleted {
                print(resultDic.value)
                let url = "\(OrderChangeShatus)\((self.model.orderId)!)/"
                let parameters = ["status":"7"]
                BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters as AnyObject).observe { (resultDic) in
                    if !resultDic.isCompleted {
                        let tempModel = OrderList.init(fromDictionary: resultDic.value as! NSDictionary)
                        self.model.status = tempModel.status
                        self.model.statusDesc = tempModel.statusDesc
                        self.model.supplierStatusDesc = tempModel.supplierStatusDesc
                        if self.reloadeMyOrderDeatail != nil {
                            self.reloadeMyOrderDeatail(self.indexPath, self.model)
                        }
                        
                        self.controller.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    
//        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters as AnyObject).observe { (resultDic) in
//            if !resultDic.isCompleted {
//                let url = "\(OrderChangeShatus)\((self.model.orderId)!)/"
//                let parameters = ["status":"7"]
//                BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters as AnyObject).observe { (resultDic) in
//                    if !resultDic.isCompleted {
//                        let tempModel = OrderList.init(fromDictionary: resultDic.value as! NSDictionary)
//                        self.model.status = tempModel.status
//                        self.model.statusDesc = tempModel.statusDesc
//                        self.model.supplierStatusDesc = tempModel.supplierStatusDesc
//                        if self.reloadeMyOrderDeatail != nil {
//                            self.reloadeMyOrderDeatail(self.indexPath, self.model)
//                        }
//                        
//                        self.controller.navigationController?.popViewController(animated: true)
//                    }
//                }
//            }
//            
//        }
    }
    
    func tableViewNumberRowInSection(_ section:Int) ->Int {
        switch section {
        case 0:
            return 1
        default:
            return isUploadImage ? 4 : 3
        }
    }
    
    func tableViewHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return controller.tableView.fd_heightForCell(withIdentifier: "UserAddressTableViewCell", configuration: { (cell) in
                self.configCellReviceCell(cell as! UserAddressTableViewCell, indexPath: indexPath)
            })
        default:
            if indexPath.row == 3 {
                return 65
            }
            return 49
        }
    }
    
    func tableViewHeiFootView(_ tableView:UITableView, section:Int) ->CGFloat{
        return 10
    }
    
    func configCellReviceCell(_ cell:UserAddressTableViewCell, indexPath:IndexPath) {
        cell.setUpData(self.model, info: "配送信息")
    }
    
    func tableViewDidSelectRowAtIndexPath(_ indexPath:IndexPath, controller:DelivererPushViewController) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.showDeverliyTypePickerView()
            }
        }
    }
    
    func tableViewCellUserAddressTableViewCell(_ cell:UserAddressTableViewCell, indexPath:IndexPath){
        self.configCellReviceCell(cell, indexPath: indexPath)
    }
    
    func tableViewGloabTitleAndDetailImageCell(_ cell:GloabTitleAndDetailImageCell, indexPath:IndexPath) {
        if indexPath.row == 0 {
            cell.setData("物流公司", detail: "顺丰")
        }else{
            cell.setData("添加发货凭证", detail: isUploadImage ? "重新上传" : "点击上传照片")
        }
    }
    
    func tableViewCellGloabTitleAndTextFieldCell(_ cell:GloabTitleAndTextFieldCell, indexPath:IndexPath) {
        cell.setData("快递单号", plachString: "填写快递单号", textFieldText: "")
        cell.textField.reactive.continuousTextValues.observeValues { (resultStr) in
            self.form.deverliyNum = resultStr!
        }
    }
    
    func tableViewCellDeverliyImageTableViewCell(_ cell:DeverliyImageTableViewCell, indexPath:IndexPath) {
        cell.setUpData(self.form.image)
    }
}

extension DeverliyPushViewModel : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(_ pickView: ZHPickView!, resultString: String!) {
        let cell = self.controller.tableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! GloabTitleAndDetailImageCell
        cell.setDetailText(resultString)
        form.deverliyName = deverliyDic[resultString] as! String
    }
}
