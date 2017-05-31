//
//  AddressViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

typealias AddressTableViewSelect = (_ indexPath:IndexPath) -> Void
typealias ReloadConfimAddress = (_ model:AddressModel) ->Void

class AddressViewModel: NSObject {
    
    var addressType:AddressType = .editType
    var addressTableViewSelect:AddressTableViewSelect!
    var reloadConfimAddress:ReloadConfimAddress!
    
    var addressModels = NSMutableArray()
    var curentModel:AddressModel!
    var selectModel:AddressModel!
    var addOrEditModel:AddressModel!
    override init() {
        
    }
    static let shareInstance = AddressViewModel()
    
    func configCell(_ cell:AddressTableViewCell,indexPath:IndexPath) {
        if addressModels.count > 0 {
            if self.addressType == .addType {
                let model = AddressModel.init(fromDictionary: addressModels.object(at: indexPath.row) as! NSDictionary)
                if self.addOrEditModel != nil {
                    selectModel = self.addOrEditModel
                }
                if selectModel != nil {
                    if model.id == selectModel.id {
                        cell.updateSelectImage(true)
                    }else{
                        cell.updateSelectImage(false)
                    }
                }else if indexPath.row != 0 {
                    cell.updateSelectImage(false)
                }
                cell.setData(model)
            }else{
                let model = AddressModel.init(fromDictionary: addressModels.object(at: indexPath.row) as! NSDictionary)
                cell.updateSelectImage(false)
                cell.setData(model)
            }
        }
    }
    
    func tableViewHeightForRow(_ tableView:UITableView, indexPath:IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "AddressTableViewCell", configuration: { (cell) in
            self.configCell(cell as! AddressTableViewCell, indexPath: indexPath)
        })
    }

    func tableViewDidSelectIndexPath(_ tableView:UITableView, indexPath:IndexPath, controller:AddressViewController) {
        if self.addressType == .addType {
            for i in 0...tableView.numberOfRows(inSection: 0) - 1 {
                if indexPath.row == i {
                    let cell = tableView.cellForRow(at: indexPath) as! AddressTableViewCell
                    cell.updateSelectImage(true)
                }else{
                    if tableView.cellForRow(at: IndexPath(row: i, section: indexPath.section)) != nil {
                        let cell = tableView.cellForRow(at: IndexPath(row: i, section: indexPath.section)) as! AddressTableViewCell
                        cell.updateSelectImage(false)
                    }
                }
            }
            
            if self.addressTableViewSelect != nil {
                self.addressTableViewSelect(indexPath)
            }
        }else{
            curentModel = AddressModel.init(fromDictionary: addressModels.object(at: indexPath.row) as! NSDictionary)
            controller.pushEditAddressViewController(curentModel)
        }
    }
    
    func requestAddress(_ tableView:UITableView) {
        BaseNetWorke.sharedInstance.getUrlWithString(AddAddress, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let resultModels =  NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
                self.addressModels =  NSMutableArray.init(array: resultModels!)
                var addressModels:[AddressModel] = []
                for model in resultModels! {
                    addressModels.append(AddressModel.init(fromDictionary: model as! NSDictionary))
                }
                AddressModel.archiveRootObject(addressModels)
                tableView.reloadData()
            }
        }
    }
    
    func tableViewNumberRowInSection(_ section:Int) -> Int {
        return self.addressModels.count
    }
    
    func tableViewConfigCell(_ indexPath:IndexPath)-> String{
        switch indexPath.row{
        case 0:
            return "收货人"
        case 1:
            return "联系电话"
        default:
            return "地区"
        }
    }
    
    func addressConfigCell(_ cell:AddressTableViewCell,indexPath:IndexPath) {
        cell.setData(self.addressModels.object(at: indexPath.row) as! AddressModel)
    }
    
    func updateCellString(_ tableView:UITableView ,string:String, tag:NSInteger) {
        let cell = tableView.cellForRow(at: IndexPath.init(row: tag, section: 0)) as! GloabTitleAndDetailImageCell
        cell.detailLabel.text = string
    }
    
    func addressChange(_ controller:AddAddressViewController, type:AddAddressViewControllerType, model:AddressModel) {
        if type == .editType {
            let parameters = model.toDictionary()
            let url = "\(EditAddress)\((model.id)!)/"
            BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).observe({ (resultDic) in
                if !resultDic.isCompleted {
                    self.addOrEditModel = AddressModel.init(fromDictionary: resultDic.value as! NSDictionary)
                    if self.reloadConfimAddress != nil {
                        self.reloadConfimAddress( self.addOrEditModel)
                    }
                    controller.reloadAddressView()
                    controller.navigationController?.popViewController(animated: true)
                }
            })
        }else{
            let parameters = model.toDictionary()
            BaseNetWorke.sharedInstance.postUrlWithString(AddAddress, parameters: parameters).observe({ (resultDic) in
                if !resultDic.isCompleted {
                    self.addOrEditModel = AddressModel.init(fromDictionary: resultDic.value as! NSDictionary)
                    if self.reloadConfimAddress != nil {
                        self.reloadConfimAddress(self.addOrEditModel)
                    }
                    controller.reloadAddressView()
                    controller.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    func deleteAddress(_ controller:AddAddressViewController, model:AddressModel){
        let url = "\(EditAddress)\((model.id)!)/"
        BaseNetWorke.sharedInstance.deleteUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                if (resultDic.value is NSDictionary) && (resultDic.value as! NSDictionary).object(forKey: "fail") != nil {
                    print("请求失败")
                }else{
                    controller.reloadAddressView()
                    controller.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
