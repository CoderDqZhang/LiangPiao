
//
//  OrderDetailViewController.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderPayView: UIView {
    
    var payButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_BackGround_Color)
        self.setUpButton()
    }
    
    func setUpButton() {
        payButton = UIButton(type: .Custom)
        payButton.setTitle("立即付款", forState: .Normal)
        payButton.titleLabel?.font = Mine_AddAddress_Name_Font
        payButton.setTitleColor(UIColor.init(hexString: Mine_AddAddress_Name_Color), forState: .Normal)
        payButton.tag = 1
        payButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.addSubview(payButton)
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        payButton.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        super.updateConstraints()
    }
    
    func singTapPress(sender:UITapGestureRecognizer) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum OrderType {
    case orderWaitPay
    case orderDone
}

class OrderDetailViewController: UIViewController {

    var tableView:UITableView!
    var orderType:OrderType = .orderWaitPay
    var payView:OrderPayView!
    
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
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_TableViewBackGround_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(TicketDetailInfoTableViewCell.self, forCellReuseIdentifier: "TicketDetailInfoTableViewCell")
        tableView.registerClass(TicketLocationTableViewCell.self, forCellReuseIdentifier: "TicketLocationTableViewCell")
        tableView.registerClass(OrderMuchTableViewCell.self, forCellReuseIdentifier: "OrderMuchTableViewCell")
        tableView.registerClass(OrderPayTableViewCell.self, forCellReuseIdentifier: "OrderPayTableViewCell")
        tableView.registerClass(OrderDoneTableViewCell.self, forCellReuseIdentifier: "OrderDoneTableViewCell")
        tableView.registerClass(OrderWaitePayTableViewCell.self, forCellReuseIdentifier: "OrderWaitePayTableViewCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
        }
        
        payView = OrderPayView(frame: CGRectMake(0, SCREENHEIGHT - 49 - 64, SCREENWIDTH, 49))
        payView.payButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            if self.viewModel.model.status == 0 {
                self.viewModel.requestPayModel(self)
            }else if self.viewModel.model.status == 7 {
                self.viewModel.requestOrderStatusChange(self)
            }
        }
        self.view.addSubview(payView)
        self.bindViewModel()
    }
    
    func setNavigationItem() {
        self.title = "订单详情"
        self.setNavigationItemBack()
        if viewModel.model.deliveryType != 1 {
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
        if viewModel.model.payUrl == nil && viewModel.model.status == 0 {
            viewModel.requestPayUrl(self)
        }        
        self.updateTableView(viewModel.model.status)
    }
    
    func updateTableView(status:Int) {
        if status == 0 || status == 7 || status == 100 {
            if payView != nil {
                payView.hidden = false
            }else{
                payView = OrderPayView(frame: CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH, 49))
                self.view.addSubview(payView)
            }
            if status == 7 {
                payView.payButton.setTitle("确认收货", forState: .Normal)
                payView.payButton.tag = 2
            }
            if status == 100 || status == 0 {
                payView.payButton.tag = 1
                payView.payButton.setTitle("立即付款", forState: .Normal)
            }
            tableView.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.view.snp_top).offset(0)
                make.left.equalTo(self.view.snp_left).offset(0)
                make.right.equalTo(self.view.snp_right).offset(0)
                make.bottom.equalTo(self.payView.snp_top).offset(0)
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
        orderConfirmView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        return orderConfirmView
    }
    
    
    func tableforFootView() -> UIView {
        let footView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,118))
        footView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,-0.5,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        footView.addSubview(imageView)
        let orderInfo = self.createLabel(CGRectMake(15,20,SCREENWIDTH - 30,14), text: "订单编号：\(viewModel.model.id)")
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
        label.font = Home_Ticket_Introuduct_Font
        label.textColor = UIColor.init(hexString: Home_Ticket_Introuduct_Color)
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
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberRowInSection(tableView, section: section)
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            return self.tableforFootView()
        }else if section == 0{
            return self.tableOrderFooterView()
        }
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if viewModel.model.status == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderWaitePayTableViewCell", forIndexPath: indexPath) as! OrderWaitePayTableViewCell
                cell.selectionStyle = .None
                viewModel.tableViewCellOrderWaitePayTableViewCell(cell)
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderDoneTableViewCell", forIndexPath: indexPath) as! OrderDoneTableViewCell
                cell.selectionStyle = .None
                viewModel.tableViewCellOrderDoneTableViewCell(cell)
                return cell
            }
         case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("TicketDetailInfoTableViewCell", forIndexPath: indexPath) as! TicketDetailInfoTableViewCell
                cell.ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover_02")
                viewModel.tableViewCellTicketDetailInfoTableViewCell(cell)
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("TicketLocationTableViewCell", forIndexPath: indexPath) as! TicketLocationTableViewCell
                viewModel.tableViewCellTicketLocationTableViewCell(cell, controller: self)
                cell.selectionStyle = .None
                return cell
            }
        default:
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderMuchTableViewCell", forIndexPath: indexPath) as! OrderMuchTableViewCell
                viewModel.tableViewCellOrderMuchTableViewCell(cell)
                cell.selectionStyle = .None
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderPayTableViewCell", forIndexPath: indexPath) as! OrderPayTableViewCell
                viewModel.tableViewCellOrderPayTableViewCell(cell)
                cell.selectionStyle = .None
                return cell
            }
        }
    }
}
