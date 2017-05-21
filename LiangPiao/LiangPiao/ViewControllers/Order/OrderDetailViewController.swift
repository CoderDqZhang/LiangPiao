
//
//  OrderDetailViewController.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum OrderType {
    case orderWaitPay
    case orderDone
}

class OrderDetailViewController: UIViewController {

    var tableView:UITableView!
    var orderType:OrderType = .orderWaitPay
    var payView:GloableBottomButtonView!
    var reciveView:GloableBottomOrder!
    
    var viewModel:OrderDetailViewModel = OrderDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setNavigationItem()
        self.talKingDataPageName = "订单详情"
        viewModel.requestPayUrl(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.isOrderConfim {
            self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = false
        }
    }
    
    
    func setUpView() {
        viewModel.controller = self
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(OrderNumberTableViewCell.self, forCellReuseIdentifier: "OrderNumberTableViewCell")
        tableView.register(TicketDetailInfoTableViewCell.self, forCellReuseIdentifier: "TicketDetailInfoTableViewCell")
        tableView.register(TicketLocationTableViewCell.self, forCellReuseIdentifier: "TicketLocationTableViewCell")
        tableView.register(OrderStatusMuchTableViewCell.self, forCellReuseIdentifier: "OrderStatusMuchTableViewCell")
        tableView.register(OrderPayTableViewCell.self, forCellReuseIdentifier: "OrderPayTableViewCell")
        tableView.register(OrderDoneTableViewCell.self, forCellReuseIdentifier: "OrderDoneTableViewCell")
        tableView.register(OrderWaitePayTableViewCell.self, forCellReuseIdentifier: "OrderWaitePayTableViewCell")
        tableView.register(ReciveAddressTableViewCell.self, forCellReuseIdentifier: "ReciveAddressTableViewCell")
        tableView.register(DeverliyTableViewCell.self, forCellReuseIdentifier: "DeverliyTableViewCellDetail")
        tableView.register(TicketRemarkTableViewCell.self, forCellReuseIdentifier: "TicketRemarkTableViewCell")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
        }
        self.updateTableView(self.viewModel.model.status)
        self.bindViewModel()
    }
    
    func setNavigationItem() {
        self.navigationItem.title =  "订单详情"
        self.setNavigationItemBack()
//        if viewModel.model.deliveryType != 1 && self.viewModel.model.status != 0 {
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "联系商家", style: .plain, target: self, action: #selector(OrderDetailViewController.rightBarItemPress(_:)))
//        }
        
    }
    
    override func backBtnPress(_ sender:UIButton){
        self.view.endEditing(true)
        if (self.navigationController?.viewControllers)!.count == 2 {
            self.navigationController?.popViewController(animated: true)
        }else{
            for controller in (self.navigationController?.viewControllers)! {
                if controller is TicketDescriptionViewController {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    }
    
    func rightBarItemPress(_ sender:UIBarButtonItem) {
        if viewModel.model.ticket.supplier != nil
        {
            AppCallViewShow(self.view, phone: viewModel.model.ticket.supplier.mobileNum.phoneType(viewModel.model.ticket.supplier.mobileNum))
        }
    }
    
    func bindViewModel(){
        if viewModel.model.payUrl == nil && Int(viewModel.model.status) == 0 {
            viewModel.requestPayUrl(self)
        }
        if viewModel.model.status >= 7 {
            viewModel.getDeverliyTrac()
        }
        self.updateTableView(viewModel.model.status)
    }
    
    func updateTableView(_ status:Int) {
//        if status != 2 && status !=   {
        if status == 7 {
            let types = [CustomButtonType.withBackBoarder,CustomButtonType.withBoarder,self.viewModel.model.expressInfo.photo == nil || self.viewModel.model.expressInfo.photo == "" ? CustomButtonType.widthDisbale : CustomButtonType.withBoarder]
            let titles = ["确认收货","联系卖家","查看凭证"]
            let frame = CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENHEIGHT, height: 49)
            reciveView = GloableBottomOrder.init(frame:frame
                , titles: titles, types: types, gloableBottomOrderClouse: { (tag) in
                    if tag == 1 {
                        self.viewModel.requestOrderStatusChange(self)
                    }else if tag == 2 {
                        if self.viewModel.model.ticket.supplier != nil
                        {
                            AppCallViewShow(self.view, phone: self.viewModel.model.ticket.supplier.mobileNum.phoneType(self.viewModel.model.ticket.supplier.mobileNum))
                        }
                    }else{
                        if self.viewModel.model.expressInfo.photo == nil || self.viewModel.model.expressInfo.photo == "" {
                            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "请联系卖家上传凭证", autoHidder: true)
                        }else{
                            self.viewModel.presentImageBrowse(self.reciveView)
                        }
                    }
                    
            })
            self.view.addSubview(reciveView)
            if payView != nil {
                payView.isHidden = true
            }
        } else if status == 0 {
            if reciveView != nil {
                reciveView.isHidden = true
            }
            if payView != nil {
                payView.isHidden = false
            }else{
                payView = GloableBottomButtonView.init(frame: nil, title: "立即付款", tag: 1, action: { (tag) in
                    if self.viewModel.model.status == 0 {
                        self.viewModel.requestPayModel(self)
                    }
                })
                self.view.addSubview(payView)
            }
            if status == 100 || status == 0 {
                payView.updateButtonTitle("立即付款")
            }
        }else if 3 < status && status < 7{
            if payView != nil {
                payView.isHidden = true
            }
            let types = [CustomButtonType.withBoarder]
            let titles = ["联系卖家"]
            let frame = CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENHEIGHT, height: 49)
            reciveView = GloableBottomOrder.init(frame:frame
                , titles: titles, types: types, gloableBottomOrderClouse: { (tag) in
                    if tag == 1 {
                        if self.viewModel.model.ticket.supplier != nil
                        {
                            AppCallViewShow(self.view, phone: self.viewModel.model.ticket.supplier.mobileNum.phoneType(self.viewModel.model.ticket.supplier.mobileNum))
                        }
                    }
            })
            self.view.addSubview(reciveView)
        }else if status > 7{
            if payView != nil {
                payView.isHidden = true
            }
            let types = [CustomButtonType.withBackBoarder,self.viewModel.model.expressInfo.photo == nil || self.viewModel.model.expressInfo.photo == "" ? CustomButtonType.widthDisbale : CustomButtonType.withBoarder]
            let titles = ["联系卖家","查看凭证"]
            let frame = CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENHEIGHT, height: 49)
            reciveView = GloableBottomOrder.init(frame:frame
                , titles: titles, types: types, gloableBottomOrderClouse: { (tag) in
                    if tag == 1 {
                        if self.viewModel.model.ticket.supplier != nil
                        {
                            AppCallViewShow(self.view, phone: self.viewModel.model.ticket.supplier.mobileNum.phoneType(self.viewModel.model.ticket.supplier.mobileNum))
                        }
                    }else {
                        if self.viewModel.model.expressInfo.photo == nil || self.viewModel.model.expressInfo.photo == "" {
                            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "请联系卖家上传凭证", autoHidder: true)
                        }else{
                            self.viewModel.presentImageBrowse(self.reciveView)
                        }
                    }
            })
            self.view.addSubview(reciveView)
            if payView != nil {
                payView.isHidden = true
            }
        }
        
        tableView.snp.remakeConstraints({ (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-49)
        })
        if status == 2 || status == 3 {
            tableView.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.view.snp.top).offset(0)
                make.left.equalTo(self.view.snp.left).offset(0)
                make.right.equalTo(self.view.snp.right).offset(0)
                make.bottom.equalTo(self.view.snp.bottom).offset(0)
            })
        }
//        }
            
//            else{
//            if payView != nil {
//                payView.isHidden = true
//                
//            }
//            tableView.snp.remakeConstraints { (make) in
//                make.top.equalTo(self.view.snp.top).offset(0)
//                make.left.equalTo(self.view.snp.left).offset(0)
//                make.right.equalTo(self.view.snp.right).offset(0)
//                make.bottom.equalTo(self.view.snp.bottom).offset(0)
//            }
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableOrderFooterView() -> UIView {
        let orderConfirmView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 12))
        orderConfirmView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        return orderConfirmView
    }
    
    
    func tableforFootView() -> UIView {
        let footView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 118))
        footView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRect(x: 0,y: -0.5,width: SCREENWIDTH,height: 4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        footView.addSubview(imageView)
        
        let service = self.createLabel(CGRect(x: 15,y: 20,width: SCREENWIDTH - 30,height: 14), text: "订单时间：\((viewModel.model.created)!)")
        footView.addSubview(service)
        
        
        let servicePhone = self.createLabel(CGRect(x: 15,y: 36,width: SCREENWIDTH - 30,height: 14), text: "客服电话：400-873-8011")
        footView.addSubview(servicePhone)
        
        
        let serviceTime = self.createLabel(CGRect(x: 15,y: 52,width: SCREENWIDTH - 30,height: 14), text: "客服工作时间：周一至周六 09:00-21:00")
        footView.addSubview(serviceTime)
        
        return footView
    }

    
    func createLabel(_ frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = App_Theme_PinFan_R_12_Font
        label.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        return label
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func orderStatuesCell(_ tableView:UITableView, indexPath:IndexPath) -> OrderStatusMuchTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusMuchTableViewCell", for: indexPath) as! OrderStatusMuchTableViewCell
        viewModel.tableViewCellOrderMuchTableViewCell(cell)
        cell.selectionStyle = .none
        return cell
    }
    
    func orderPayCell(_ tableView:UITableView, indexPath:IndexPath) ->OrderPayTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderPayTableViewCell", for: indexPath) as! OrderPayTableViewCell
        viewModel.tableViewCellOrderPayTableViewCell(cell)
        cell.selectionStyle = .none
        return cell
    }

}

extension OrderDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath, controller:self)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeiFootView(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeiFootView(tableView, section: section)
    }
    
    
}

extension OrderDetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberRowInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return self.tableforFootView()
        }else if section == 0{
            return self.tableOrderFooterView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if viewModel.viewModelWailOrCancelStatus() {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderWaitePayTableViewCell", for: indexPath) as! OrderWaitePayTableViewCell
                    cell.selectionStyle = .none
                    viewModel.tableViewCellOrderWaitePayTableViewCell(cell, indexPath:indexPath)
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDoneTableViewCell", for: indexPath) as! OrderDoneTableViewCell
                    cell.selectionStyle = .none
                    viewModel.tableViewCellOrderDoneTableViewCell(cell, indexPath:indexPath)
                    return cell
                }
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReciveAddressTableViewCell", for: indexPath) as! ReciveAddressTableViewCell
                viewModel.tableViewCellReciveAddressTableViewCell(cell, indexPath: indexPath)
                cell.selectionStyle = .none
                return cell
            default:
                if viewModel.deverliyModel != nil && viewModel.deverliyModel.traces.count > 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DeverliyTableViewCellDetail", for: indexPath) as! DeverliyTableViewCell
                    viewModel.tableViewCellDeverliyTableViewCell(cell, indexPath: indexPath)
                    cell.selectionStyle = .none
                    return cell
                }else{
                    var cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
                    if cell == nil {
                        cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "defaultCell")
                    }
                    return cell!
                }
                
            }
         default :
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderNumberTableViewCell", for: indexPath) as! OrderNumberTableViewCell
                cell.isUserInteractionEnabled = false
                viewModel.tableViewOrderCellIndexPath(indexPath, cell: cell)
                cell.selectionStyle = .none
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TicketDetailInfoTableViewCell", for: indexPath) as! TicketDetailInfoTableViewCell
                cell.ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover_02")
                viewModel.tableViewCellTicketDetailInfoTableViewCell(cell)
                cell.selectionStyle = .none
                return cell
            }else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TicketLocationTableViewCell", for: indexPath) as! TicketLocationTableViewCell
                viewModel.tableViewCellTicketLocationTableViewCell(cell, indexPath:indexPath)
                
                cell.selectionStyle = .none
                return cell
            }else if indexPath.row == 3 {
                if viewModel.viewModelHaveRemarkMessage() {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TicketRemarkTableViewCell", for: indexPath) as! TicketRemarkTableViewCell
                    viewModel.tableViewCellOrderTicketRemarkTableViewCell(cell, indexPath: indexPath)
                    cell.selectionStyle = .none
                    return cell
                }
                return self.orderPayCell(tableView, indexPath: indexPath)
            }else if indexPath.row == 4{
                if viewModel.viewModelHaveRemarkMessage() {
                    return self.orderPayCell(tableView, indexPath: indexPath)
                }
                return self.orderStatuesCell(tableView, indexPath: indexPath)
            }else{
                return self.orderStatuesCell(tableView, indexPath: indexPath)
            }
        }
    }
}
