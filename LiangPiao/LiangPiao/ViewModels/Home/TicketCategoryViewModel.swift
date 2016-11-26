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
    var tempCategory:NSMutableArray = NSMutableArray()
    
    var willAddViewController:NSInteger = 0
    
    var selectIdex:Int = 0
    
    private override init() {
        
    }
    
    static let sharedInstance = TicketCategoryViewModel()
    
    func genderData(models:NSMutableArray) {
        let nomalDic = ["id":0,"name":"全部","showCount":10]
        let nomalModel = TicketCategorys.init(fromDictionary: nomalDic)
        tempCategory.addObject(nomalModel)
        categoryModels.addObject(nomalModel)
        pageControllers.addObject(BaseTicketsPageViewController())
        let array = NSMutableArray()
        reconmmendModels.addObject(array)
        for dic in models {
            let model = TicketCategorys.init(fromDictionary: dic as! NSDictionary)
            if model.showCount != 0 {
                tempCategory.addObject(model)
                categoryModels.addObject(nomalModel)
                pageControllers.addObject(BaseTicketsPageViewController())
                reconmmendModels.addObject(array)
            }
        }
        for i in 0...tempCategory.count - 1 {
            let model = tempCategory[i] as! TicketCategorys
            if model.name == "话剧歌剧" {
                categoryModels.replaceObjectAtIndex(1, withObject: model)
            }else if model.name == "演唱会" {
                categoryModels.replaceObjectAtIndex(2, withObject: model)
            }else if model.name == "音乐会" {
                categoryModels.replaceObjectAtIndex(3, withObject: model)
            }else if model.name == "体育赛事" {
                categoryModels.replaceObjectAtIndex(4, withObject: model)
            }else if model.name == "舞蹈芭蕾" {
                categoryModels.replaceObjectAtIndex(5, withObject: model)
            }else if model.name == "曲苑杂技" {
                categoryModels.replaceObjectAtIndex(6, withObject: model)
            }
        }
        
    }
    
    func requestCategotyDic(controller:TicketPageViewController, index:Int) {
        if categoryModels.count == 0 {
            BaseNetWorke.sharedInstance.getUrlWithString(TickeCategoty, parameters: nil).subscribeNext { (resultDic) in
                let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
                self.genderData(resultModels)
                controller.reloadData()
                controller.moveToControllerAtIndex(index, animated: false)

            }
        }else{
            controller.reloadData()
            controller.moveToControllerAtIndex(index, animated: false)
        }
    }
    
    func requestCategotyData(index:Int, controller:BaseTicketsPageViewController) {
        let model:TicketCategorys
        let url:String
        if index == 1000 {
            model = categoryModels.objectAtIndex(selectIdex) as! TicketCategorys
            let recommentModel:RecommentTickes = reconmmendModels[selectIdex] as! RecommentTickes
            url = "\(TickeCategotyList)?cat_id=\(recommentModel.nextStart)"
        }else{
            model = categoryModels.objectAtIndex(index) as! TicketCategorys
            url = "\(TickeCategotyList)?cat_id=\(model.id)"
        }
        controller.talKingDataPageName = model.name
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  RecommentTickes.init(fromDictionary: resultDic as! NSDictionary)
            if index == 1000 {
                self.reconmmendModels.replaceObjectAtIndex(self.selectIdex, withObject: resultModels)
            }else{
                self.reconmmendModels.replaceObjectAtIndex(index, withObject: resultModels)
            }
            controller.isLoadData = true
            controller.tableView.reloadData()
        }
    }
    
    func refreshDataView(controller:BaseTicketsPageViewController){
        let model = categoryModels.objectAtIndex(selectIdex) as! TicketCategorys
        let url = "\(TickeCategotyList)?cat_id=\(model.id)"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  RecommentTickes.init(fromDictionary: resultDic as! NSDictionary)
            self.reconmmendModels.replaceObjectAtIndex(self.selectIdex, withObject: resultModels)
            
            controller.tableView.reloadData()
            controller.tableView.mj_header.endRefreshing()
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
        let pageController = pageControllers.objectAtIndex(willAddViewController) as! BaseTicketsPageViewController
        if pageController.isLoadData {
            return (reconmmendModels[selectIdex] as! RecommentTickes).showList.count
        }else{
            return 0
        }
//        if reconmmendModels[selectIdex] is RecommentTickes && willAddViewController == selectIdex {
//            return (reconmmendModels[selectIdex] as! RecommentTickes).showList.count
//        }
    }
    
    func tableViewCellForRowAtIndexPath(cell:RecommendTableViewCell, indexPath:NSIndexPath) {
        if reconmmendModels[selectIdex] is RecommentTickes {
            let recommentModel:RecommentTickes = reconmmendModels[selectIdex] as! RecommentTickes
            cell.setData(recommentModel.showList[indexPath.row])
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath, controller:BaseTicketsPageViewController){
        let recommentModel:RecommentTickes = reconmmendModels[selectIdex] as! RecommentTickes
        self .getTicketScent(recommentModel.showList[indexPath.row], controller: controller)
    }
    
    func getTicketScent(model:HomeTicketModel,controller:BaseTicketsPageViewController){
        let url = "\(TickeSession)\(model.id)/session"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            if resultModels.count > 1{
                let controllerVC = TicketSceneViewController()
                controllerVC.viewModel.model = model
                NavigationPushView(controller, toConroller: controllerVC)
            }else{
                let controllerVC = TicketDescriptionViewController()
                NavigationPushView(controller, toConroller: controllerVC)
            }
        }
    }
}
