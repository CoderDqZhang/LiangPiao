//
//  OrderStatusTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

let orxginX:CGFloat = 50

class OrderStatusTableViewCell: UITableViewCell {

    
    let orderStatusArray:NSArray = ["提交申请","待确认","待付款","待见面"]
    var flowView:ZDQFlowView!
    var orderStatus:String!
    var statusType:String!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        flowView = ZDQFlowView(frame: CGRect(x: orxginX,y: 42,width: SCREENWIDTH - orxginX * 2,height: 40))
        flowView.dataSource = self
        self.contentView.addSubview(flowView)
    }
    
    func setData(status:String,statusType:String) {
        self.orderStatus = status
        self.statusType = statusType
        flowView.reloadData()
        self.updateConstraintsIfNeeded()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension OrderStatusTableViewCell: ZDQFlowViewDataSource {
    func numberOfFlowViewItemCount(flowView: ZDQFlowView) -> NSInteger {
        return 4
    }
    
    func numberOfFlowViewItem(flowView: ZDQFlowView, index: NSInteger) -> ZDQFlowViewItem {
        let viewItem = ZDQFlowViewItem()
        if orderStatus == "0" {
            switch index {
            case 0:
                viewItem.setData("待付款",type: ZDQFlowViewItemType.itemWaitSelect)
            case 1:
                viewItem.setData("待发货",type: ZDQFlowViewItemType.itemWaitSelect)
            case 2:
                viewItem.setData("待收货",type: ZDQFlowViewItemType.itemWaitSelect)
            default:
                viewItem.setData("待结算",type: ZDQFlowViewItemType.itemWaitSelect)
            }
        }else if orderStatus == "3"{
            switch index {
            case 0:
                viewItem.setData("已付款",type: ZDQFlowViewItemType.itemSelect)
            case 1:
                viewItem.setData("待发货",type: ZDQFlowViewItemType.itemWaitSelect)
            case 2:
                viewItem.setData("待收货",type: ZDQFlowViewItemType.itemWaitSelect)
            default:
                viewItem.setData("待结算",type: ZDQFlowViewItemType.itemWaitSelect)
            }
        }else if orderStatus == "7" {
            switch index {
            case 0:
                viewItem.setData("已付款",type: ZDQFlowViewItemType.itemDone)
            case 1:
                viewItem.setData("已发货",type: ZDQFlowViewItemType.itemSelect)
            case 2:
                viewItem.setData("待收货",type: ZDQFlowViewItemType.itemWaitSelect)
            default:
                viewItem.setData("待结算",type: ZDQFlowViewItemType.itemWaitSelect)
            }
        }else if orderStatus == "9" || orderStatus == "8" {
            switch index {
            case 0:
                viewItem.setData("已付款",type: ZDQFlowViewItemType.itemDone)
            case 1:
                viewItem.setData("已发货",type: ZDQFlowViewItemType.itemDone)
            case 2:
                viewItem.setData("已收货",type: ZDQFlowViewItemType.itemSelect)
            default:
                viewItem.setData("待结算",type: ZDQFlowViewItemType.itemWaitSelect)
            }
        }else if orderStatus == "10" {
            switch index {
            case 0:
                viewItem.setData("已付款",type: ZDQFlowViewItemType.itemDone)
            case 1:
                viewItem.setData("已发货",type: ZDQFlowViewItemType.itemDone)
            case 2:
                viewItem.setData("已收货",type: ZDQFlowViewItemType.itemDone)
            default:
                viewItem.setData("已结算",type: ZDQFlowViewItemType.itemDone)
            }
        }
        
        return viewItem
    }
    
    func flowViewItemSize(flowView: ZDQFlowView) -> CGSize {
        return CGSize(width: 45, height: 57)
    }
}
