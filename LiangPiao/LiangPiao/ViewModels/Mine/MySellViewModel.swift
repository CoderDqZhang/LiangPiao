//
//  MySellViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellViewModel: NSObject {

    var pageViewControllers:NSMutableArray!
    let pageTitle = ["订单交易","票品管理"]
    var controller:MySellPagerViewController!
    override init() {
        super.init()
        let mySellOrder = MySellOrderViewController()
        mySellOrder.viewModel = self
        let mySellManager = MySellManagerViewController()
        mySellManager.viewModel = self
        pageViewControllers = NSMutableArray.init(array: [mySellOrder,mySellManager])

    }
    
    // MARK :TaPageViewController
    func numberOfControllersInPagerController() -> Int{
        return self.pageTitle.count
    }
    
    func pagerControllerTitleForIndex(index:Int) -> String{
        return pageTitle[index] 
    }
    
    func pagerControllerControllerForIndex(index:Int) -> UIViewController {
        return pageViewControllers[index] as! UIViewController 
    }
    
    //MARK: MySellViewController
    func mySellOrderTableViewDidSelect(indexPath:NSIndexPath, controller:MySellPagerViewController){
        NavigationPushView(self.controller, toConroller: MyTicketPutUpViewController())
    }
    
    func mySellOrderNumberOfSection() -> Int{
        return 10
    }
    
    func mySellOrderNumbrOfRowInSection(section:Int) ->Int{
        return 3
    }
    
    func mySellTableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        switch indexPath.row {
        case 0:
            return 49
        case 1:
            return 149
        default:
            return 59
        }
    }
    
    //MARK: MySellOrderMangerViewController
    func mySellOrderManagerTableViewDidSelect(indexPath:NSIndexPath, controller:MySellPagerViewController){
        NavigationPushView(self.controller, toConroller: MyTicketPutUpViewController())
    }
    
    func mySellOrderManagerNumberOfSection() -> Int{
        return 10
    }
    
    func mySellOrderManagerNumbrOfRowInSection(section:Int) ->Int{
        return 3
    }
    
    func mySellOrderManagerTableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        switch indexPath.row {
        case 0:
            return 193
        case 1:
            return 59
        default:
            return 49
        }
    }
}
