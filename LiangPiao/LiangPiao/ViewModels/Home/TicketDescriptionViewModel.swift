//
//  TicketDescriptionViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 21/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TicketDescriptionViewModel: NSObject {

    var ticketModel:TicketShowModel!
    var model:TicketDescriptionModel!
    var ticketNumber:NSInteger = 1
    var tempList:[TicketList]!
    var controller:TicketDescriptionViewController!
    var ticketPriceArray:NSMutableArray = NSMutableArray()
    var ticketRowArray:NSArray = NSArray()
    
    var plachImage:UIImage!
    
    override init() {
        super.init()
    }
    
    func getPriceArray(array:[TicketList]){
        let sortArray = array.sort { (oldList, newList) -> Bool in
            return oldList.originalTicket.price < newList.originalTicket.price
        }
        var minPrice = 0
        for list in sortArray {
            if minPrice < list.originalTicket.price {
               ticketPriceArray.addObject(list.originalTicket.name)
               minPrice = list.originalTicket.price
            }
        }
    }
    
    func getRowArray(array:[TicketList]){
        let arrays = NSMutableArray()
        for array in array {
            if array.region != "" {
                arrays.addObject("\(array.region) \(array.row)排")
            }
        }
        let set = NSSet(array: arrays as [AnyObject])
        let sortDec = NSSortDescriptor.init(key: nil, ascending: true)
        ticketRowArray = set.sortedArrayUsingDescriptors([sortDec])
    }
    
    func tableViewHeight(row:Int) -> CGFloat
    {
        switch row {
        case 0:
            return 188
        case 1:
            if ticketModel.session.venueMap != nil && ticketModel.session.venueMap != "" {
                return SCREENWIDTH * 170/375
            }
            return 0.00000000001
        case 2:
            return 80
        case 3:
            return 42
        default:
            if self.model.ticketList.count == 0 {
                return SCREENHEIGHT - 374
            }
            return 60
        }
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    func tableViewnumberOfRowsInSection(section:Int) -> Int{
        if self.model != nil{
            if self.model.ticketList.count == 0 {
                return 5
            }
            return self.model.ticketList.count + 4
        }
        return 0
    }
    
    func configCellTicketDescripTableViewCell(cell:TicketDescripTableViewCell) {
        if model != nil {
            cell.setData(model.show,sessionModel: model.session)
        }
    }
    
    func configCellTickerInfoTableViewCell(cell:TickerInfoTableViewCell, indexPath:NSIndexPath) {
        if model != nil {
            cell.setData(model.ticketList[indexPath.row - 4])
        }
    }
    
    func configCellTicketNumberTableViewCell(cell:TicketNumberTableViewCell){
        cell.numberTickView.numberTextField.rac_observeKeyPath("text", options: .New, observer: nil) { (object, objects,isNew, isOld) in
            self.ticketNumber = NSInteger(object as! String)!
        }
    }
    
    func configTicketMapTableViewCell(cell:TicketMapTableViewCell, indexPath:NSIndexPath) {
        if ticketModel.session.venueMap != nil {
            cell.ticketMap.sd_setImageWithURL(NSURL.init(string: ticketModel.session.venueMap), placeholderImage: UIImage.init(color: UIColor.init(hexString: App_Theme_F6F7FA_Color), size: CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 170/375))) { (image, error, cacheType, url) in
                self.plachImage = image
            }
        }
    }
    
    func requestTicketSession(){
        if self.ticketModel != nil {
            var url = ""
            if ticketModel.session != nil {
                url = "\(TickeSession)\(ticketModel.id)/session/\(ticketModel.session.id)"
            }else if ticketModel.session != nil {
                url = "\(TickeSession)\(ticketModel.id)/session/\(ticketModel.session.id)"
            }
            BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
                self.model = TicketDescriptionModel.init(fromDictionary: resultDic as! NSDictionary)
                self.tempList = self.model.ticketList
                self.getPriceArray(self.tempList)
                self.getRowArray(self.tempList)
                
                self.controller.tableView.reloadData()
                self.controller.updataLikeImage()
            }
        }
    }
    
    func requestNotificationUrl(url:String ,controllerVC: TicketDescriptionViewController){
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            self.model = TicketDescriptionModel.init(fromDictionary: resultDic as! NSDictionary)
            self.tempList = self.model.ticketList
            self.getPriceArray(self.tempList)
            self.getRowArray(self.tempList)
            if controllerVC.tableView == nil {
                controllerVC.setUpView()
            }
            controllerVC.tableView.reloadData()
            controllerVC.updataLikeImage()
            
        }
    }
    
    func requestCollectTicket(){
        let url = "\(TicketFavorite)"
        let parameters = ["show_id":model.show.id]
        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
            MainThreadAlertShow("已加入想看", view: KWINDOWDS())
        }
    }
    
    func requestDeleteCollectTicket(){
        let url = "\(TicketFavorite)"
        let parameters = ["show_id":model.show.id]
        BaseNetWorke.sharedInstance.deleteUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
            MainThreadAlertShow("已从想看移除", view: KWINDOWDS())
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath) {
        if UserInfoModel.isLoggedIn() {
            if indexPath.row == 2 {
                let cell = controller.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0)) as! TicketMapTableViewCell
               self.presentImageBrowse(cell.contentView)
            }else if indexPath.row > 3 && self.model.ticketList.count > 0{
                let ticketModel = self.model.ticketList[indexPath.row - 4]
                if ticketModel.sellType == 2 && ticketModel.remainCount > self.ticketNumber {
                    UIAlertController.shwoAlertControl(self.controller, style: .Alert, title: nil, message: "该票种须打包\(ticketModel.remainCount)张一起购买哦", cancel: "取消", doneTitle: "继续购买", cancelAction: {
                        
                        }, doneAction: {
                            self.ticketNumber = ticketModel.remainCount
                            self.pushTicketDescription(indexPath)
                    })
                }else{
                    self.pushTicketDescription(indexPath)
                }
                
            }
        }else{
            NavigationPushView(self.controller, toConroller: LoginViewController())
        }
    }
    
    func presentImageBrowse(sourceView:UIView){
        let photoBrowser = SDPhotoBrowser()
        photoBrowser.delegate = self
        photoBrowser.currentImageIndex = 0
        photoBrowser.imageCount = 1
        photoBrowser.backgroundColor = UIColor.whiteColor()
        photoBrowser.sourceImagesContainerView = sourceView
        photoBrowser.imageBlock = { index in
            
        }
        photoBrowser.show()
    }
    
    func pushTicketDescription(indexPath:NSIndexPath){
        let controllerVC = TicketConfirmViewController()
        controllerVC.viewModel.model = self.model
        controllerVC.viewModel.ticketModel = self.model.ticketList[indexPath.row - 4]
        let typeArray = self.model.ticketList[indexPath.row - 4].deliveryType.componentsSeparatedByString(",")
        for str in typeArray {
            if str == "1" {
                 controllerVC.viewModel.formType = .withNomal
                 controllerVC.viewModel.orderForme.deliveryType = .expressage
                 controllerVC.viewModel.formDelevityType = .expressage
            }
        }
        controllerVC.viewModel.remainCount = self.getTicketNumber(indexPath)
        controllerVC.viewModel.muchOfTicket = self.getMuchOfTicket(indexPath)
        NavigationPushView(self.controller, toConroller: controllerVC)
    }
    
    func getTicketNumber(indexPath:NSIndexPath) -> Int {
        let ticketModel = self.model.ticketList[indexPath.row - 4]
        if self.ticketNumber > ticketModel.remainCount {
            return ticketModel.remainCount
        }else{
            return self.ticketNumber
        }
    }
    
    func getMuchOfTicket(indexPath:NSIndexPath) -> String {
        let ticketModel = self.model.ticketList[indexPath.row - 4]
        let str = "\(self.getTicketNumber(indexPath) * ticketModel.price)"
        return str
    }
    
    
    func sortTicket(type:TicketSortType){
        switch type {
        case .noneType,.upType:
            let tickesList = self.model.ticketList
            self.model.ticketList = tickesList.sort({ (downList, upList) -> Bool in
                return downList.price < upList.price
            })
        default:
            let tickesList = self.model.ticketList
            self.model.ticketList = tickesList.sort({ (downList, upList) -> Bool in
                return downList.price > upList.price
            })
        }
        self.controller.tableView.reloadData()
    }
    
    func sortTickeByOriginTicketPrice(price:String?) {
        if price == "0" {
            self.model.ticketList = tempList
        }else{
            var sortArrayList:[TicketList] = []
            for tickeModel in tempList {
                if tickeModel.originalTicket.name == price {
                    sortArrayList.append(tickeModel)
                }
            }
            self.model.ticketList = sortArrayList
        }
        self.controller.tableView.reloadData()
    }
    
    func sortTickeByRowTicketPrice(ticketRow:String?) {
        if ticketRow == "0" {
            self.model.ticketList = tempList
        }else{
            var sortArrayList:[TicketList] = []
            for tickeModel in tempList {
                var rowStr = ""
                if tickeModel.region != "" {
                    rowStr = "\(tickeModel.region) \(tickeModel.row)排"
                }
                if rowStr == ticketRow {
                    sortArrayList.append(tickeModel)
                }
            }
            self.model.ticketList = sortArrayList
            self.controller.tableView.reloadData()
        }
    }
}

extension TicketDescriptionViewModel : SDPhotoBrowserDelegate {
    func photoBrowser(browser: SDPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        if ticketModel.session.venueMap != nil {
            return NSURL.init(string: ticketModel.session.venueMap)
        }
        return NSURL.init(string: "")
    }
    
    func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return plachImage == nil ? UIImage.init(color: UIColor.init(hexString: App_Theme_F6F7FA_Color), size: CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 170/375)) : plachImage
    }
}
