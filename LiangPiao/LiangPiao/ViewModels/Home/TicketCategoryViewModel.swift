//
//  TicketCategoryViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 22/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class TicketCategoryViewModel: NSObject {

    var models = NSMutableArray()
    var categoryModels:NSMutableArray = NSMutableArray()
    var pageViewTitles:NSMutableArray!
    var pageControllers:NSMutableArray = NSMutableArray()
    var reconmmendModels:NSMutableArray = NSMutableArray()
    
    
    var selectIdex:Int = 0
    
    private override init() {
        
    }
    
    static let sharedInstance = TicketCategoryViewModel()
    
    func genderData(models:NSMutableArray) {
        let nomalDic = ["id":0,"name":"全部","showCount":10]
        let nomalModel = TicketCategorys.init(fromDictionary: nomalDic)
        categoryModels.addObject(nomalModel)
        pageControllers.addObject(BaseTicketsPageViewController())
        let array = NSMutableArray()
        reconmmendModels.addObject(array)
        for dic in models {
            let model = TicketCategorys.init(fromDictionary: dic as! NSDictionary)
            if model.showCount != 0 {
                categoryModels.addObject(model)
                pageControllers.addObject(BaseTicketsPageViewController())
                reconmmendModels.addObject(array)
            }
        }
        
    }
    
    func requestCategotyDic(controller:TicketPageViewController, index:Int) {
        if categoryModels.count == 0 {
            BaseNetWorke.sharedInstance.getUrlWithString(TickeCategoty, parameters: nil).subscribeNext { (resultDic) in
                if  ((resultDic is NSDictionary) && (resultDic as! NSDictionary).objectForKey("fail") != nil) {
                    print("请求失败")
                }else{
                    let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
                    self.genderData(resultModels)
                    controller.reloadData()
                    controller.moveToControllerAtIndex(index, animated: false)
                }
            }
        }else{
            controller.reloadData()
            controller.moveToControllerAtIndex(index, animated: false)
        }
    }
    
    func requestCategotyData(index:Int, controller:BaseTicketsPageViewController) {
        let model = categoryModels.objectAtIndex(index) as! TicketCategorys
        BaseNetWorke.sharedInstance.getUrlWithString("\(TickeCategotyList)?cat_id=\(model.id)", parameters: nil).subscribeNext { (resultDic) in
            if  ((resultDic is NSDictionary) && (resultDic as! NSDictionary).objectForKey("fail") != nil) {
                print("请求失败")
            }else{
                let resultModels =  RecommentTickes.init(fromDictionary: resultDic as! NSDictionary)
                self.reconmmendModels.replaceObjectAtIndex(index, withObject: resultModels)
                controller.tableView.reloadData()
            }
        }
    }
    
    func numberOfControllersInPagerController() -> Int {
        return categoryModels.count
    }
    
    func pagerControllerDidScrollToTabPageIndex(index:Int) {
        selectIdex = index
        if pageControllers.count != 0 {
            self.requestCategotyData(index, controller: pageControllers[index] as! BaseTicketsPageViewController)
        }
    }
    
    func pagerControllerTitleForIndex(index:Int) ->String {
        let dic = categoryModels.objectAtIndex(index) as! TicketCategorys
        return dic.name
    }
    
    func pagerControllerControllerForIndex(index:Int) ->UIViewController {
        return pageControllers[index] as! UIViewController
    }
    
    
    func numberOfRowsInSection() ->Int {
        if reconmmendModels[selectIdex] is RecommentTickes {
            return (reconmmendModels[selectIdex] as! RecommentTickes).showList.count
        }
        return reconmmendModels[selectIdex].count as Int
    }
    
    func tableViewCellForRowAtIndexPath(cell:RecommendTableViewCell, indexPath:NSIndexPath) {
        if reconmmendModels[selectIdex] is RecommentTickes {
            let recommentModel:RecommentTickes = reconmmendModels[selectIdex] as! RecommentTickes
            cell.setData(recommentModel.showList[indexPath.row])
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath, controller:BaseTicketsPageViewController){
        let controllerVC = TicketSceneViewController()
        let recommentModel:RecommentTickes = reconmmendModels[selectIdex] as! RecommentTickes
        controllerVC.viewModel.model = recommentModel.showList[indexPath.row]
        NavigationPushView(controller, toConroller: controllerVC)
    }
}
