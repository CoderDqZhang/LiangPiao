//
//  AddressViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

typealias AddressTableViewSelect = (indexPath:NSIndexPath) -> Void

class AddressViewModel: NSObject {
    
    var addressType:AddressType = .editType
    var addressTableViewSelect:AddressTableViewSelect!
    
    var addressModels = NSMutableArray()
    var curentModel:AddressModel!
    var selectModel:AddressModel!
    
    override init() {
        
    }
    
    func configCell(cell:AddressTableViewCell,indexPath:NSIndexPath) {
        if addressModels.count > 0 {
            if self.addressType == .addType {
                let model = AddressModel.init(fromDictionary: addressModels.objectAtIndex(indexPath.row) as! NSDictionary)
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
                let model = AddressModel.init(fromDictionary: addressModels.objectAtIndex(indexPath.row) as! NSDictionary)
                cell.updateSelectImage(false)
                cell.setData(model)
            }
        }
    }
    
    func tableViewHeightForRow(tableView:UITableView, indexPath:NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier("AddressTableViewCell", configuration: { (cell) in
            self.configCell(cell as! AddressTableViewCell, indexPath: indexPath)
        })
    }

    func tableViewDidSelectIndexPath(tableView:UITableView, indexPath:NSIndexPath, controller:AddressViewController) {
        if self.addressType == .addType {
            for i in 0...tableView.numberOfRowsInSection(0) - 1 {
                if indexPath.row == i {
                    let cell = tableView.cellForRowAtIndexPath(indexPath) as! AddressTableViewCell
                    cell.updateSelectImage(true)
                }else{
                    let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: indexPath.section)) as! AddressTableViewCell
                    cell.updateSelectImage(false)
                }
            }
            if self.addressTableViewSelect != nil {
                self.addressTableViewSelect(indexPath:indexPath)
            }
        }else{
            curentModel = AddressModel.init(fromDictionary: addressModels.objectAtIndex(indexPath.row) as! NSDictionary)
            controller.pushEditAddressViewController(curentModel)
        }
    }
    
    func requestAddress(tableView:UITableView) {
        BaseNetWorke.sharedInstance.getUrlWithString(AddAddress, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            self.addressModels = resultModels.mutableCopy() as! NSMutableArray
            var addressModels:[AddressModel] = []
            for model in resultModels {
                addressModels.append(AddressModel.init(fromDictionary: model as! NSDictionary))
            }
            AddressModel.archiveRootObject(addressModels)
            tableView.reloadData()
        }
    }
    
    func tableViewNumberRowInSection(section:Int) -> Int {
        return self.addressModels.count
    }
    
    func tableViewConfigCell(indexPath:NSIndexPath)-> String{
        switch indexPath.row{
        case 0:
            return "收货人姓名"
        case 1:
            return "联系电话"
        default:
            return "地区"
        }
    }
    
    func addressConfigCell(cell:AddressTableViewCell,indexPath:NSIndexPath) {
        cell.setData(self.addressModels.objectAtIndex(indexPath.row) as! AddressModel)
    }
    
    func updateCellString(tableView:UITableView ,string:String, tag:NSInteger) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: tag, inSection: 0)) as! GloabTitleAndDetailImageCell
        cell.detailLabel.text = string
    }
    
    func addressChange(controller:AddAddressViewController, type:AddAddressViewControllerType, model:AddressModel) {
        if type == .EditType {
            let parameters = model.toDictionary()
            let url = "\(EditAddress)\(model.id)/"
            BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext({ (resultDic) in
                controller.reloadAddressView()
                controller.navigationController?.popViewControllerAnimated(true)
            })
        }else{
            let parameters = model.toDictionary()
            BaseNetWorke.sharedInstance.postUrlWithString(AddAddress, parameters: parameters).subscribeNext({ (resultDic) in
                controller.reloadAddressView()
                controller.navigationController?.popViewControllerAnimated(true)
            })
        }
    }
    
    func deleteAddress(controller:AddAddressViewController, model:AddressModel){
        let url = "\(EditAddress)\(model.id)/"
        BaseNetWorke.sharedInstance.deleteUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            if (resultDic is NSDictionary) && (resultDic as! NSDictionary).objectForKey("fail") != nil {
                print("请求失败")
            }else{
                controller.reloadAddressView()
                controller.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
}
