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
    
    fileprivate override init() {
        
    }
    
    static let sharedInstance = TicketCategoryViewModel()
    
    func genderData(_ models:NSMutableArray) {
        let nomalDic = ["id":Int64(0),"name":"全部","showCount":Int64(10)] as [String : Any]
        let nomalModel = TicketCategorys.init(fromDictionary: nomalDic as NSDictionary)
        tempCategory.add(nomalModel)
        categoryModels.add(nomalModel)
        pageControllers.add(BaseTicketsPageViewController())
        let array = NSMutableArray()
        reconmmendModels.add(array)
        for dic in models {
            let model = TicketCategorys.init(fromDictionary: dic as! NSDictionary)
            if model.showCount != 0 {
                tempCategory.add(model)
                categoryModels.add(nomalModel)
                pageControllers.add(BaseTicketsPageViewController())
                reconmmendModels.add(array)
            }
        }
        for i in 0...tempCategory.count - 1 {
            let model = tempCategory[i] as! TicketCategorys
            if model.name == "演唱会" {
                categoryModels.replaceObject(at: 1, with: model)
            }else if model.name == "话剧歌剧" {
                categoryModels.replaceObject(at: 2, with: model)
            }else if model.name == "音乐会" {
                categoryModels.replaceObject(at: 3, with: model)
            }else if model.name == "体育赛事" {
                categoryModels.replaceObject(at: 4, with: model)
            }else if model.name == "舞蹈芭蕾" {
                categoryModels.replaceObject(at: tempCategory.count - i, with: model)
            }else if model.name == "曲苑杂技" {
                categoryModels.replaceObject(at: tempCategory.count - i, with: model)
            }
        }
        
    }
    
    func requestCategotyDic(_ controller:TicketPageViewController, index:Int) {
        if categoryModels.count == 0 {
            BaseNetWorke.sharedInstance.getUrlWithString(TickeCategoty, parameters: nil).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let resultModels =  NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
                    self.genderData(resultModels!)
                    controller.reloadData()
                    controller.moveToController(at: index, animated: false)
                }
            }
        }else{
            controller.reloadData()
            controller.moveToController(at: index, animated: false)
        }
    }
    
    func requestCategotyData(_ index:Int, controller:BaseTicketsPageViewController) {
        let model:TicketCategorys
        let url:String
        if index == 1000 {
            model = categoryModels.object(at: selectIdex) as! TicketCategorys
            let recommentModel:RecommentTickes = reconmmendModels[selectIdex] as! RecommentTickes
            if recommentModel.hasNext == false {
                controller.tableView.mj_footer.endRefreshing()
                return
            }
            url = "\(TickeCategotyList)?cat_id=\((model.id)!)&start=\((recommentModel.nextStart)!)"
        }else{
            model = categoryModels.object(at: index) as! TicketCategorys
            url = "\(TickeCategotyList)?cat_id=\((model.id)!)"
        }
        controller.talKingDataPageName = model.name
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let resultModels =  RecommentTickes.init(fromDictionary: resultDic.value as! NSDictionary)
                if index == 1000 {
                    let recommentTickes = self.reconmmendModels.object(at: self.selectIdex) as! RecommentTickes
                    recommentTickes.hasNext = resultModels.hasNext
                    recommentTickes.nextStart = resultModels.nextStart
                    recommentTickes.showList.append(contentsOf: resultModels.showList)
                    self.reconmmendModels.replaceObject(at: self.selectIdex, with: recommentTickes)
                    controller.tableView.mj_footer.endRefreshing()
                }else{
                    self.reconmmendModels.replaceObject(at: index, with: resultModels)
                }
                controller.isLoadData = true
                if controller.tableView.mj_footer == nil && (resultModels.hasNext != nil) && resultModels.hasNext == true {
                    controller.setUpLoadMoreData()
                }
                controller.tableView.reloadData()
            }
        }
    }
    
    func refreshDataView(_ controller:BaseTicketsPageViewController){
        let model = categoryModels.object(at: selectIdex) as! TicketCategorys
        let url = "\(TickeCategotyList)?cat_id=\((model.id)!)"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let resultModels =  RecommentTickes.init(fromDictionary: resultDic.value as! NSDictionary)
                self.reconmmendModels.replaceObject(at: self.selectIdex, with: resultModels)
                
                controller.tableView.reloadData()
                controller.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    func numberOfControllersInPagerController() -> Int {
        return categoryModels.count
    }
    
    func pagerControllerDidScrollToTabPageIndex(_ index:Int) {
        selectIdex = index
        if pageControllers.count != 0 {
            if !(reconmmendModels[index] is RecommentTickes){
                self.requestCategotyData(index, controller: pageControllers[index] as! BaseTicketsPageViewController)
            }
        }
    }
    
    func pagerControllerTitleForIndex(_ index:Int) ->String {
        let dic = categoryModels.object(at: index) as! TicketCategorys
        return dic.name
    }
    
    func pagerControllerControllerForIndex(_ index:Int) ->UIViewController {
        return pageControllers[index] as! UIViewController
    }
    
    
    func numberOfRowsInSection() ->Int {
        let pageController = pageControllers.object(at: willAddViewController) as! BaseTicketsPageViewController
        if pageController.isLoadData && (reconmmendModels[selectIdex] is RecommentTickes) {
            return (reconmmendModels[selectIdex] as! RecommentTickes).showList.count
        }else{
            return 0
        }
    }
    
    func tableViewCellForRowAtIndexPath(_ cell:RecommendTableViewCell, indexPath:IndexPath) {
        if reconmmendModels[selectIdex] is RecommentTickes {
            let recommentModel:RecommentTickes = reconmmendModels[selectIdex] as! RecommentTickes
            if recommentModel.showList.count > indexPath.row {
                cell.setData(recommentModel.showList[indexPath.row])
            }
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(_ indexPath:IndexPath, controller:BaseTicketsPageViewController){
        let recommentModel:RecommentTickes = reconmmendModels[selectIdex] as! RecommentTickes
        if recommentModel.showList[indexPath.row].sessionCount == 1 {
            let controllerVC = TicketDescriptionViewController()
            controllerVC.viewModel.ticketModel = recommentModel.showList[indexPath.row]
            NavigationPushView(controller, toConroller: controllerVC)
        }else{
            let controllerVC = TicketSceneViewController()
            controllerVC.viewModel.model = recommentModel.showList[indexPath.row]
            NavigationPushView(controller, toConroller: controllerVC)
        }
    }
}
