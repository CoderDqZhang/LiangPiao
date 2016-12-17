//
//  OrderDeliveryTypeViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum OrderDeliveryType {
    case Nomal
    case Recivi
    case Visite
    case All
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

typealias OrderDeliveryTypeViewModelClouse = (devilyArray:NSMutableArray) -> Void

class OrderDeliveryTypeViewModel: NSObject {

    var type = OrderDeliveryType.Nomal
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
        delviTypeArray.addObject(express)
        delviTypeArray.addObject(present)
        delviTypeArray.addObject(visite)
        if self.orderDeliveryTypeViewModelClouse != nil {
            self.orderDeliveryTypeViewModelClouse(devilyArray:delviTypeArray)
            controller.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func updateDeliveryType(){
        if isVisite && isRecivi {
            self.type = .All
        }else if isRecivi {
            self.type = .Recivi
        }else if isVisite {
            self.type = .Visite
        }else{
            self.type = .Nomal
        }
    }
    
    func numberOfSection() ->Int {
        return 1
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        switch type {
        case .Nomal:
            return 3
        case .All:
            return 9
        default:
            return 6
        }
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        if type == .Recivi {
            switch indexPath.row {
            case 0:
                return 91
            case 2:
                return 45
            default:
                return 49
            }
        }else if type == .Visite{
            switch indexPath.row {
            case 0:
                return 91
            case 4:
                return 45
            default:
                return 49
            }
        }else if type == .All {
            switch indexPath.row {
            case 0:
                return 91
            case 2,6:
                return 45
            default:
                return 49
            }
        }else{
            switch indexPath.row {
            case 0:
                return 91
            default:
                return 49
            }
        }
    }

    
    func talbleViewCellGloabTextFieldCell(cell:GloabTextFieldCell, indexPath:NSIndexPath){
        switch indexPath.row {
        case 2:
            cell.textField.placeholder = "输入取票地点"
            if self.present.address != "" {
                cell.textField.text = self.present.address
            }
            cell.textField.rac_textSignal().subscribeNext({ (str) in
                self.present.address = str as! String
            })
        case 3:
            if self.type == .Visite {
                cell.textField.placeholder = "输入取票地点"
                if self.visite.address != "" {
                    cell.textField.text = self.visite.address
                }
                cell.textField.rac_textSignal().subscribeNext({ (str) in
                    self.visite.address = str as! String
                })
            }else{
                cell.textField.placeholder = "输入取票时间"
                if self.present.time != "" {
                    cell.textField.text = self.present.time
                }
                cell.textField.rac_textSignal().subscribeNext({ (str) in
                    self.present.time = str as! String
                })
            }
        case 4:
            if self.type == .Visite {
                cell.textField.placeholder = "联系电话"
                if self.visite.phone != "" {
                    cell.textField.text = self.visite.phone
                }
                cell.textField.rac_textSignal().subscribeNext({ (str) in
                    self.visite.phone = str as! String
                })
            }else{
                cell.textField.placeholder = "联系电话"
                if self.present.phone != "" {
                    cell.textField.text = self.present.phone
                }
                cell.textField.rac_textSignal().subscribeNext({ (str) in
                    self.present.phone = str as! String
                })
            }
        case 5,8:
            cell.textField.placeholder = "输入取票时间"
            if self.visite.time != "" {
                cell.textField.text = self.visite.time
            }
            cell.textField.rac_textSignal().subscribeNext({ (str) in
                self.visite.time = str as! String
            })
        case 6:
            cell.textField.placeholder = "输入取票地点"
            if self.visite.address != "" {
                cell.textField.text = self.visite.address
            }
            cell.textField.rac_textSignal().subscribeNext({ (str) in
                self.visite.address = str as! String
            })
        case 7:
            cell.textField.placeholder = "联系电话"
            if self.visite.phone != "" {
                cell.textField.text = self.visite.phone
            }
            cell.textField.rac_textSignal().subscribeNext({ (str) in
                self.visite.phone = str as! String
            })
        default:
            break
        }
    }
    
    func talbleViewcellOrderExpressTableViewCell(cell:OrderExpressTableViewCell, indexPath:NSIndexPath){
        cell.switchBar.setOn(self.express.isSelect, animated: true)
        cell.switchBar.rac_signalForControlEvents(.ValueChanged).subscribeNext { (value) in
            self.express.isSelect = (value as! UISwitch).on
        }
    }
    
    func talbleViewCellGloabTitleAndSwitchBarTableViewCell(cell:GloabTitleAndSwitchBarTableViewCell, indexPath:NSIndexPath, controller:OrderDeliveryTypeViewController){
        switch indexPath.row {
        case 1:
            cell.titleLabel.text = "现场取票"
            if self.isRecivi || self.type == .All {
                cell.hidderLineLabel()
            }else{
                cell.showLineLabel()
            }
            if cell.titleLabel.text == "现场取票" {
                cell.setTitleLabel("现场取票", isSelect: self.present.isSelect)
                cell.switchBar.rac_signalForControlEvents(.ValueChanged).subscribeNext({ (value) in
                    self.isRecivi = (value as! UISwitch).on
                    self.updateDeliveryType()
                    self.present.isSelect = self.isRecivi
                    controller.tableView.reloadData()
                })
            }
            
        default:
            cell.hidderLineLabel()
            cell.titleLabel.text = "上门自取"
            if cell.titleLabel.text == "上门自取" {
                cell.setTitleLabel("上门自取", isSelect: self.visite.isSelect)
                cell.switchBar.rac_signalForControlEvents(.ValueChanged).subscribeNext({ (value) in
                    self.isVisite = (value as! UISwitch).on
                    self.updateDeliveryType()
                    self.visite.isSelect = self.isVisite
                    controller.tableView.reloadData()
                })
            }
        }
    }
    
    func talbleViewCellOrderExpressDetailTableViewCell(cell:OrderExpressDetailTableViewCell, indexPath:NSIndexPath){
        switch indexPath.row {
        case 2:
            cell.setData("北京市崇文区东花市北里20号楼6单元501室")
            self.present.address = cell.textLabel?.text
        default:
            cell.setData("北京市崇文区东花市北里20号楼6单元501室sfsdfs")
            self.visite.address = cell.textLabel?.text
        }
    }

}
