
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
    
    var viewModel:OrderDetailViewModel = OrderDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setNavigationItem()
        self.talKingDataPageName = "订单详情"
        viewModel.requestPayUrl(self)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.isOrderConfim {
            self.navigationController?.fd_fullscreenPopGestureRecognizer.enabled = false
        }
    }
    
    
    func setUpView() {
        viewModel.controller = self
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(OrderNumberTableViewCell.self, forCellReuseIdentifier: "OrderNumberTableViewCell")
        tableView.registerClass(TicketDetailInfoTableViewCell.self, forCellReuseIdentifier: "TicketDetailInfoTableViewCell")
        tableView.registerClass(TicketLocationTableViewCell.self, forCellReuseIdentifier: "TicketLocationTableViewCell")
        tableView.registerClass(OrderStatusMuchTableViewCell.self, forCellReuseIdentifier: "OrderStatusMuchTableViewCell")
        tableView.registerClass(OrderPayTableViewCell.self, forCellReuseIdentifier: "OrderPayTableViewCell")
        tableView.registerClass(OrderDoneTableViewCell.self, forCellReuseIdentifier: "OrderDoneTableViewCell")
        tableView.registerClass(OrderWaitePayTableViewCell.self, forCellReuseIdentifier: "OrderWaitePayTableViewCell")
        tableView.registerClass(ReciveAddressTableViewCell.self, forCellReuseIdentifier: "ReciveAddressTableViewCell")
        tableView.registerClass(DeverliyTableViewCell.self, forCellReuseIdentifier: "DeverliyTableViewCellDetail")
        tableView.registerClass(TicketRemarkTableViewCell.self, forCellReuseIdentifier: "TicketRemarkTableViewCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
        }
        
        payView = GloableBottomButtonView.init(frame: nil, title: "立即付款", tag: 1, action: { (tag) in
            if self.viewModel.model.status == 0 || self.viewModel.model.status == 100 {
                self.viewModel.requestPayModel(self)
            }else if self.viewModel.model.status == 7 {
                self.viewModel.requestOrderStatusChange(self)
            }
        })
    
        self.view.addSubview(payView)
        self.bindViewModel()
    }
    
    func setNavigationItem() {
        self.navigationItem.title =  "订单详情"
        self.setNavigationItemBack()
        if viewModel.model.deliveryType != 1 && self.viewModel.model.status != 0 {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "联系商家", style: .Plain, target: self, action: #selector(OrderDetailViewController.rightBarItemPress(_:)))
        }
        
    }
    
    override func backBtnPress(sender:UIButton){
        self.view.endEditing(true)
        if (self.navigationController?.viewControllers)!.count == 2 {
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            for controller in (self.navigationController?.viewControllers)! {
                if controller is TicketDescriptionViewController {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    }
    
    func rightBarItemPress(sender:UIBarButtonItem) {
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
    
    func updateTableView(status:Int) {
        if status == 0 || status == 7 || status == 100 {
            if payView != nil {
                payView.hidden = false
            }else{
                payView = GloableBottomButtonView.init(frame: nil, title: "立即付款", tag: 1, action: { (tag) in
                    if self.viewModel.model.status == 0 {
                        self.viewModel.requestPayModel(self)
                    }else if self.viewModel.model.status == 7 {
                        self.viewModel.requestOrderStatusChange(self)
                    }
                })
                self.view.addSubview(payView)
            }
            if status == 7 {
                payView.updateButtonTitle("确认收货")
            }
            if status == 100 || status == 0 {
                payView.updateButtonTitle("立即付款")
            }
            tableView.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.view.snp_top).offset(0)
                make.left.equalTo(self.view.snp_left).offset(0)
                make.right.equalTo(self.view.snp_right).offset(0)
                make.bottom.equalTo(self.view.snp_bottom).offset(-49)
            })
        }else{
            if payView != nil {
                payView.hidden = true
                
            }
            tableView.snp_remakeConstraints { (make) in
                make.top.equalTo(self.view.snp_top).offset(0)
                make.left.equalTo(self.view.snp_left).offset(0)
                make.right.equalTo(self.view.snp_right).offset(0)
                make.bottom.equalTo(self.view.snp_bottom).offset(0)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableOrderFooterView() -> UIView {
        let orderConfirmView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,12))
        orderConfirmView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        return orderConfirmView
    }
    
    
    func tableforFootView() -> UIView {
        let footView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,118))
        footView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRectMake(0,-0.5,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        footView.addSubview(imageView)
        let orderInfo = self.createLabel(CGRectMake(15,20,SCREENWIDTH - 30,14), text: "订单号：\(viewModel.model.id)")
        footView.addSubview(orderInfo)
        
        let service = self.createLabel(CGRectMake(15,36,SCREENWIDTH - 30,14), text: "订单时间：\(viewModel.model.created)")
        footView.addSubview(service)
        
        
        let servicePhone = self.createLabel(CGRectMake(15,52,SCREENWIDTH - 30,14), text: "客服电话：400-873-8011")
        footView.addSubview(servicePhone)
        
        
        let serviceTime = self.createLabel(CGRectMake(15,68,SCREENWIDTH - 30,14), text: "客服工作时间：周一至周六 09:00-21:00")
        footView.addSubview(serviceTime)
        
        return footView
    }

    
    func createLabel(frame:CGRect, text:String) -> UILabel {
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
    
    func orderStatuesCell(tableView:UITableView, indexPath:NSIndexPath) -> OrderStatusMuchTableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderStatusMuchTableViewCell", forIndexPath: indexPath) as! OrderStatusMuchTableViewCell
        viewModel.tableViewCellOrderMuchTableViewCell(cell)
        cell.selectionStyle = .None
        return cell
    }
    
    func orderPayCell(tableView:UITableView, indexPath:NSIndexPath) ->OrderPayTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderPayTableViewCell", forIndexPath: indexPath) as! OrderPayTableViewCell
        viewModel.tableViewCellOrderPayTableViewCell(cell)
        cell.selectionStyle = .None
        return cell
    }

}

extension OrderDetailViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath, controller:self)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeiFootView(tableView, section: section)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeiFootView(tableView, section: section)
    }
    
    
}

extension OrderDetailViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberRowInSection(tableView, section: section)
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return self.tableforFootView()
        }else if section == 0{
            return self.tableOrderFooterView()
        }
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if viewModel.viewModelWailOrCancelStatus() {
                    let cell = tableView.dequeueReusableCellWithIdentifier("OrderWaitePayTableViewCell", forIndexPath: indexPath) as! OrderWaitePayTableViewCell
                    cell.selectionStyle = .None
                    viewModel.tableViewCellOrderWaitePayTableViewCell(cell, indexPath:indexPath)
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCellWithIdentifier("OrderDoneTableViewCell", forIndexPath: indexPath) as! OrderDoneTableViewCell
                    cell.selectionStyle = .None
                    viewModel.tableViewCellOrderDoneTableViewCell(cell, indexPath:indexPath)
                    return cell
                }
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("ReciveAddressTableViewCell", forIndexPath: indexPath) as! ReciveAddressTableViewCell
                viewModel.tableViewCellReciveAddressTableViewCell(cell, indexPath: indexPath)
                cell.selectionStyle = .None
                return cell
            default:
                if viewModel.deverliyModel != nil && viewModel.deverliyModel.traces.count > 0 {
                    let cell = tableView.dequeueReusableCellWithIdentifier("DeverliyTableViewCellDetail", forIndexPath: indexPath) as! DeverliyTableViewCell
                    viewModel.tableViewCellDeverliyTableViewCell(cell, indexPath: indexPath)
                    cell.selectionStyle = .None
                    return cell
                }else{
                    var cell = tableView.dequeueReusableCellWithIdentifier("defaultCell")
                    if cell == nil {
                        cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "defaultCell")
                    }
                    return cell!
                }
                
            }
         default :
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderNumberTableViewCell", forIndexPath: indexPath) as! OrderNumberTableViewCell
                cell.userInteractionEnabled = false
                viewModel.tableViewOrderCellIndexPath(indexPath, cell: cell)
                cell.selectionStyle = .None
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("TicketDetailInfoTableViewCell", forIndexPath: indexPath) as! TicketDetailInfoTableViewCell
                cell.ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover_02")
                viewModel.tableViewCellTicketDetailInfoTableViewCell(cell)
                cell.selectionStyle = .None
                return cell
            }else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier("TicketLocationTableViewCell", forIndexPath: indexPath) as! TicketLocationTableViewCell
                viewModel.tableViewCellTicketLocationTableViewCell(cell, indexPath:indexPath)
                
                cell.selectionStyle = .None
                return cell
            }else if indexPath.row == 3 {
                if viewModel.viewModelHaveRemarkMessage() {
                    let cell = tableView.dequeueReusableCellWithIdentifier("TicketRemarkTableViewCell", forIndexPath: indexPath) as! TicketRemarkTableViewCell
                    viewModel.tableViewCellOrderTicketRemarkTableViewCell(cell, indexPath: indexPath)
                    cell.selectionStyle = .None
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
