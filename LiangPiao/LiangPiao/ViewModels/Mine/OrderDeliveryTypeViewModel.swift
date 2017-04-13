//
//  OrderDeliveryTypeViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum OrderDeliveryType {
    case nomal
    case recivi
    case visite
    case all
}

class Expressage: NSObject {
    var isSelect:Bool = true
}

class Present: NSObject {
    var isSelect:Bool = false
    var address:String!
    var time:String!
    var phone:String!
}

class Visite: NSObject {
    var isSelect:Bool = false
    var address:String!
    var time:String!
    var phone:String!
}

typealias OrderDeliveryTypeViewModelClouse = (_ devilyArray:NSMutableArray) -> Void

class OrderDeliveryTypeViewModel: NSObject {

    var type = OrderDeliveryType.nomal
    var isVisite:Bool = false
    var isRecivi:Bool = false
    var express:Expressage!
    var present:Present!
    var visite:Visite!
    var delviTypeArray:NSMutableArray = NSMutableArray()
    var orderDeliveryTypeViewModelClouse:OrderDeliveryTypeViewModelClouse!
    var controller:OrderDeliveryTypeViewController!
    
    override init() {
        super.init()
    }
    
    func saveDelivery(){
        delviTypeArray.add(express)
        if self.present.isSelect {
            if self.present.address == "" {
                UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "请输入地址", message: nil, cancel: nil, doneTitle: "我知道了", cancelAction: { 
                    
                    }, doneAction: { 
                        
                })
                return
            }else if self.present.time == "" {
                UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "请输入时间", message: nil, cancel: nil, doneTitle: "我知道了", cancelAction: {
                    
                    }, doneAction: {
                        
                })
                return
            }else if self.present.phone == "" {
                UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "请输入电话", message: nil, cancel: nil, doneTitle: "我知道了", cancelAction: {
                    
                    }, doneAction: {
                        
                })
                return
            }
        }
        delviTypeArray.add(present)
        if self.visite.isSelect {
            if self.visite.address == "" {
                UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "请输入地址", message: nil, cancel: nil, doneTitle: "我知道了", cancelAction: {
                    
                    }, doneAction: {
                        
                })
                return
            }else if self.visite.time == "" {
                UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "请输入时间", message: nil, cancel: nil, doneTitle: "我知道了", cancelAction: {
                    
                    }, doneAction: {
                        
                })
                return
            }else if self.visite.phone == "" {
                UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "请输入电话", message: nil, cancel: nil, doneTitle: "我知道了", cancelAction: {
                    
                    }, doneAction: {
                        
                })
                return
            }
        }
        delviTypeArray.add(visite)
        if self.orderDeliveryTypeViewModelClouse != nil {
            self.orderDeliveryTypeViewModelClouse(delviTypeArray)
            controller.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateDeliveryType(){
        if isVisite && isRecivi {
            self.type = .all
        }else if isRecivi {
            self.type = .recivi
        }else if isVisite {
            self.type = .visite
        }else{
            self.type = .nomal
        }
    }
    
    func numberOfSection() ->Int {
        return 1
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
        switch type {
        case .nomal:
            return 3
        case .all:
            return 9
        default:
            return 6
        }
    }
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        if type == .recivi {
            switch indexPath.row {
            case 0:
                return 49
            case 2:
                return 45
            default:
                return 49
            }
        }else if type == .visite{
            switch indexPath.row {
            case 0:
                return 49
            case 4:
                return 45
            default:
                return 49
            }
        }else if type == .all {
            switch indexPath.row {
            case 0:
                return 49
            case 2,6:
                return 45
            default:
                return 49
            }
        }else{
            switch indexPath.row {
            case 0:
                return 49
            default:
                return 49
            }
        }
    }

    
    func talbleViewCellGloabTextFieldCell(_ cell:GloabTextFieldCell, indexPath:IndexPath){
        switch indexPath.row {
        case 2:
            cell.textField.placeholder = "输入取票地点"
            if self.present.address != "" {
                cell.textField.text = self.present.address
            }
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                self.present.address = str!
            })
        case 3:
            if self.type == .visite {
                cell.textField.placeholder = "输入取票地点"
                if self.visite.address != "" {
                    cell.textField.text = self.visite.address
                }
                cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                    self.visite.address = str!
                })
            }else{
                cell.textField.placeholder = "输入取票时间"
                if self.present.time != "" {
                    cell.textField.text = self.present.time
                }
                cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                    self.present.time = str!
                })
            }
        case 4:
            if self.type == .visite {
                cell.textField.placeholder = "输入取票时间"
                if self.visite.time != "" {
                    cell.textField.text = self.visite.time
                }
                cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                    self.visite.time = str!
                })
            }else{
                cell.textField.placeholder = "联系电话"
                if self.present.phone != "" {
                    cell.textField.text = self.present.phone
                }
                cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                    self.present.phone = str!
                })
            }
        case 5,8:
            cell.textField.placeholder = "联系电话"
            if self.visite.phone != "" {
                cell.textField.text = self.visite.phone
            }
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                self.visite.phone = str!
            })
        case 6:
            cell.textField.placeholder = "输入取票地点"
            if self.visite.address != "" {
                cell.textField.text = self.visite.address
            }
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                self.visite.address = str!
            })
        case 7:
            cell.textField.placeholder = "输入取票时间"
            if self.visite.time != "" {
                cell.textField.text = self.visite.time
            }
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                self.visite.time = str!
            })
        default:
            break
        }
    }
    
    func talbleViewcellOrderExpressTableViewCell(_ cell:OrderExpressTableViewCell, indexPath:IndexPath){
        cell.switchBar.setOn(self.express.isSelect, animated: true)
        cell.switchBar.reactive.controlEvents(.valueChanged).observe { (event) in
            self.express.isSelect = (event.value!).isOn
        }
    }
    
    func talbleViewCellGloabTitleAndSwitchBarTableViewCell(_ cell:GloabTitleAndSwitchBarTableViewCell, indexPath:IndexPath, controller:OrderDeliveryTypeViewController){
        switch indexPath.row {
        case 0:
            cell.setTitleLabel("快递到付", isSelect: self.express.isSelect)
            cell.switchBar.reactive.controlEvents(.valueChanged).observe { (event) in
                self.express.isSelect = (event.value!).isOn
            }
        case 1:
            cell.titleLabel.text = "现场取票"
            if self.isRecivi || self.type == .all {
                cell.hidderLineLabel()
            }else{
                cell.showLineLabel()
            }
            if cell.titleLabel.text == "现场取票" {
                cell.setTitleLabel("现场取票", isSelect: self.present.isSelect)
                cell.switchBar.reactive.controlEvents(.valueChanged).observe { (event) in
                    self.isRecivi = (event.value!).isOn
                    self.updateDeliveryType()
                    self.present.isSelect = self.isRecivi
                    controller.tableView.reloadData()
                }
            }
            
        default:
            cell.hidderLineLabel()
            cell.titleLabel.text = "上门自取"
            if cell.titleLabel.text == "上门自取" {
                cell.setTitleLabel("上门自取", isSelect: self.visite.isSelect)
                cell.switchBar.reactive.controlEvents(.valueChanged).observe { (event) in
                    self.isVisite = (event.value!).isOn
                    self.updateDeliveryType()
                    self.visite.isSelect = self.isVisite
                    controller.tableView.reloadData()
                }
            }
        }
    }

}
