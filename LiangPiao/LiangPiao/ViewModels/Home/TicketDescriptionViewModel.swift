//
//  TicketDescriptionViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 21/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
    
    func getPriceArray(_ array:[TicketList]){
        let sortArray = array.sorted { (oldList, newList) -> Bool in
            return oldList.originalTicket.price < newList.originalTicket.price
        }
        var minPrice = 0
        for list in sortArray {
            if minPrice < list.originalTicket.price {
               ticketPriceArray.add(list.originalTicket.name)
               minPrice = list.originalTicket.price
            }
        }
    }
    
    func getRowArray(_ array:[TicketList]){
        let arrays = NSMutableArray()
        for array in array {
            if array.region != "" {
                arrays.add("\((array.region)!) \((array.row)!)排")
            }
        }
        let set = NSSet(array: arrays as [AnyObject])
        let sortDec = NSSortDescriptor.init(key: nil, ascending: true)
        ticketRowArray = set.sortedArray(using: [sortDec]) as NSArray
    }
    
    func tableViewHeight(_ row:Int) -> CGFloat
    {
        switch row {
        case 0:
            return 188
//        case 1:
//            if ticketModel.session.venueMap != nil && ticketModel.session.venueMap != "" {
//                return SCREENWIDTH * 170/375
//            }
//            return 0.00000000001
//        case 2:
//            return 80
        case 1:
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
    
    func tableViewnumberOfRowsInSection(_ section:Int) -> Int{
        if self.model != nil{
            if self.model.ticketList.count == 0 {
                return 3
            }
            return self.model.ticketList.count + 2
        }
        return 0
    }
    
    func configCellTicketDescripTableViewCell(_ cell:TicketDescripTableViewCell) {
        if model != nil {
            cell.setData(model.show,sessionModel: model.session)
            cell.venueMapClouse = { view in
                self.presentImageBrowse(view)
            }
        }
    }
    
    func configCellTickerInfoTableViewCell(_ cell:TickerInfoTableViewCell, indexPath:IndexPath) {
        if model != nil {
            cell.setData(model.ticketList[indexPath.row - 2])
        }
    }
    
    func configTicketMapTableViewCell(_ cell:TicketMapTableViewCell, indexPath:IndexPath) {
        if ticketModel.session.venueMap != nil {
            cell.ticketMap.sd_setImage(with: URL.init(string: ticketModel.session.venueMap), placeholderImage: UIImage.init(color: UIColor.init(hexString: App_Theme_F6F7FA_Color), size: CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 170/375)), options: .retryFailed, progress: { (start, end, url) in
                
            }, completed: { (image, error, cache, url) in
                
            })
        }
    }
    
    func requestTicketSession(){
        if self.ticketModel != nil {
            var url = ""
            if ticketModel.session != nil {
                url = "\(TickeSession)\((ticketModel.id)!)/session/\((ticketModel.session.id)!)"
            }else if ticketModel.session != nil {
                url = "\(TickeSession)\((ticketModel.id)!)/session/\((ticketModel.session.id)!)"
            }
            BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
                if !resultDic.isCompleted {
                    self.model = TicketDescriptionModel.init(fromDictionary: resultDic.value as! NSDictionary)
                    self.tempList = self.model.ticketList
                    self.getPriceArray(self.tempList)
                    self.getRowArray(self.tempList)
                    
                    self.controller.tableView.reloadData()
                    self.controller.updataLikeImage()
                }
            }
        }
    }
    
    func requestNotificationUrl(_ url:String ,controllerVC: TicketDescriptionViewController){
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = TicketDescriptionModel.init(fromDictionary: resultDic.value as! NSDictionary)
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
    }
    
    func requestCollectTicket(){
        let url = "\(TicketFavorite)"
        let parameters = ["show_id":model.show.id]
        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters as AnyObject).observe { (resultDic) in
            MainThreadAlertShow("已加入想看", view: KWINDOWDS())
        }
    }
    
    func requestDeleteCollectTicket(){
        let url = "\(TicketFavorite)"
        let parameters = ["show_id":model.show.id]
        BaseNetWorke.sharedInstance.deleteUrlWithString(url, parameters: parameters as AnyObject).observe { (resultDic) in
            MainThreadAlertShow("已从想看移除", view: KWINDOWDS())
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(_ indexPath:IndexPath) {
        
        if UserInfoModel.isLoggedIn() {
            if indexPath.row > 1 && self.model.ticketList.count > 0{
                let ticketModel = self.model.ticketList[indexPath.row - 2]
                //判断改票是否可以购买
                let dates = NSDate.string(toDate: self.model.session.name.components(separatedBy: " ")[0])
                let interval: TimeInterval = dates!.timeIntervalSince(NSDate.dateNow())
                let days = (Int(interval)) / 86400
                if interval < 0 && days <= 0 && (ticketModel.deliveryType == "4" || ticketModel.deliveryType == "1") {
                    UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "该票已不符合快递要求，可联系商家自取", message: nil, cancel: "取消", doneTitle: "联系商家", cancelAction: {
                        
                    }, doneAction: {
                        if ticketModel.supplier != nil
                        {
                            AppCallViewShow(self.controller.view, phone: ticketModel.supplier.mobileNum.phoneType(ticketModel.supplier.mobileNum))
                        }
                    })
                    return
                }
                if ticketModel.sellType == 2 {
                    UIAlertController.shwoAlertControl(self.controller, style: .alert, title: nil, message: "该票种须打包\((ticketModel.remainCount)!)张一起购买哦", cancel: "取消", doneTitle: "继续购买", cancelAction: {
                        
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
    
    func presentImageBrowse(_ sourceView:UIView){
        let photoBrowser = SDPhotoBrowser()
        photoBrowser.delegate = self
        photoBrowser.currentImageIndex = 0
        photoBrowser.imageCount = 1
        photoBrowser.backgroundColor = UIColor.white
        photoBrowser.sourceImagesContainerView = sourceView
        photoBrowser.imageBlock = { index in
            
        }
        photoBrowser.show()
    }
    
    func pushTicketDescription(_ indexPath:IndexPath){
        let controllerVC = TicketConfirmViewController()
        controllerVC.viewModel.model = self.model
        controllerVC.viewModel.ticketModel = self.model.ticketList[indexPath.row - 2]
        let typeArray = self.model.ticketList[indexPath.row - 2].deliveryType.components(separatedBy: ",")
        for str in typeArray {
            if str == "1" || str == "4" {
                 controllerVC.viewModel.formType = .withNomal
                 controllerVC.viewModel.orderForme.deliveryType = .expressage
                 controllerVC.viewModel.formDelevityType = .expressage
            }
        }
        controllerVC.viewModel.remainCount = self.getTicketNumber(indexPath)
        controllerVC.viewModel.muchOfTicket = self.getMuchOfTicket(indexPath)
        NavigationPushView(self.controller, toConroller: controllerVC)
    }
    
    func getTicketNumber(_ indexPath:IndexPath) -> Int {
        let ticketModel = self.model.ticketList[indexPath.row - 2]
        if self.ticketNumber > ticketModel.remainCount {
            return ticketModel.remainCount
        }else{
            return self.ticketNumber
        }
    }
    
    func getMuchOfTicket(_ indexPath:IndexPath) -> String {
        let ticketModel = self.model.ticketList[indexPath.row - 2]
        if ticketModel.sellType == 1 {
            return "\(1 * ticketModel.price)"
        }else{
            return "\(self.getTicketNumber(indexPath) * ticketModel.price)"
        }
    }
    
    
    func sortTicket(_ type:TicketSortType){
        switch type {
        case .noneType,.upType:
            let tickesList = self.model.ticketList
            self.model.ticketList = tickesList?.sorted(by: { (downList, upList) -> Bool in
                return downList.price < upList.price
            })
        default:
            let tickesList = self.model.ticketList
            self.model.ticketList = tickesList?.sorted(by: { (downList, upList) -> Bool in
                return downList.price > upList.price
            })
        }
        self.controller.tableView.reloadData()
    }
    
    func sortTickeByOriginTicketPrice(_ price:String?) {
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
    
    func sortTickeByRowTicketPrice(_ ticketRow:String?) {
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
    func photoBrowser(_ browser: SDPhotoBrowser!, highQualityImageURLFor index: Int) -> URL! {
        if ticketModel.session.venueMap != nil {
            return URL.init(string: ticketModel.session.venueMap)
        }
        return URL.init(string: "")
    }
    
    func photoBrowser(_ browser: SDPhotoBrowser!, placeholderImageFor index: Int) -> UIImage! {
        return plachImage == nil ? UIImage.init(color: UIColor.init(hexString: App_Theme_F6F7FA_Color), size: CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 170/375)) : plachImage
    }
}
