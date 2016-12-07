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

class OrderDeliveryTypeViewModel: NSObject {

    var type = OrderDeliveryType.Nomal
    var isVisite:Bool = false
    var isRecivi:Bool = false
    
    override init() {
        
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
        case 3:
          cell.textField.placeholder = "输入取票时间"
        case 4:
            cell.textField.placeholder = "联系电话"
        case 5,7:
            cell.textField.placeholder = "输入取票时间"
        case 6,8:
            cell.textField.placeholder = "联系电话"
        default:
            break
        }
    }
    
    func talbleViewcellOrderExpressTableViewCell(cell:OrderExpressTableViewCell, indexPath:NSIndexPath){
        
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
                cell.setTitleLabel("现场取票", isSelect: self.isRecivi)
                cell.switchBar.rac_signalForControlEvents(.ValueChanged).subscribeNext({ (value) in
                    self.isRecivi = (value as! UISwitch).on
                    self.updateDeliveryType()
                    controller.tableView.reloadData()
                })
            }
            
        default:
            cell.hidderLineLabel()
            cell.titleLabel.text = "上门自取"
            if cell.titleLabel.text == "上门自取" {
                cell.setTitleLabel("上门自取", isSelect: self.isVisite)
                cell.switchBar.rac_signalForControlEvents(.ValueChanged).subscribeNext({ (value) in
                    self.isVisite = (value as! UISwitch).on
                    self.updateDeliveryType()
                    controller.tableView.reloadData()
                })
            }
        }
    }
    
    
    
    func talbleViewCellOrderExpressDetailTableViewCell(cell:OrderExpressDetailTableViewCell, indexPath:NSIndexPath){
        switch indexPath.row {
        case 2:
            cell.setData("北京市崇文区东花市北里20号楼6单元501室")
        default:
            cell.setData("北京市崇文区东花市北里20号楼6单元501室sfsdfs")
        }
    }

}
