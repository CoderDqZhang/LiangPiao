
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
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(AddAddressView.singTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
        
    }
    
    func setUpButton() {
        payButton = UIButton(type: .Custom)
        payButton.setTitle("立即付款", forState: .Normal)
        payButton.titleLabel?.font = Mine_AddAddress_Name_Font
        payButton.setTitleColor(UIColor.init(hexString: Mine_AddAddress_Name_Color), forState: .Normal)
        payButton.userInteractionEnabled = false
        payButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.addSubview(payButton)
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        payButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).offset(-5)
            make.centerY.equalTo(self.snp_centerY).offset(0)
            make.width.equalTo(119)
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
        
//        self.rac_observeKeyPath(AliPayStatues, options: .New, observer: self) { (object, objects, new, obj) in
//            
//        }
//        
//        self.rac_observeKeyPath(WeiXinPayStatues, options: .New, observer: self) { (object, objects, new, obj) in
//            
//        }
        
//        self.rac_observeKeyPath(WeiXinPayStatues, options: .New, observer: self) { (object, objects, new, obj) in
//            
//        }
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WaitPayViewController.changePayStatues(_:)), name: WeiXinPayStatues, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WaitPayViewController.changePayStatues(_:)), name: AliPayStatues, object: nil)
        // Do any additional setup after loading the view.
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
        self.view.addSubview(payView)
        self.updateTableView(.orderWaitPay)
    }
    
    func setNavigationItem() {
        self.title = "订单详情"
        self.setNavigationItemBack()
    }
    
    func updateTableView(orderType:OrderType) {
        if orderType == .orderDone {
            if payView != nil {
                payView.hidden = true
                
            }
            tableView.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.view.snp_bottom).offset(0)
            })
        }else{
            if payView != nil {
                payView.hidden = false
            }else{
                payView = OrderPayView(frame: CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH, 49))
                self.view.addSubview(payView)
            }
            tableView.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(self.payView.snp_top).offset(0)
            })
        }
    }

    
    //    func loadPayInfo(){
    //        viewModel.payOrder(orderModel.order_id, successBlock: { (dic) in
    //            let payDic = dic as NSDictionary
    //            self.aliPayurl = payDic.objectForKey("alipay") as! String
    //            let weChatDic = payDic["wxpay"] as! NSDictionary;
    //            self.weChatPayreq.nonceStr = weChatDic.objectForKey("noncestr") as! String
    //            self.weChatPayreq.package = weChatDic.objectForKey("package") as! String
    //            self.weChatPayreq.partnerId = weChatDic.objectForKey("partnerid") as! String
    //            self.weChatPayreq.prepayId = weChatDic.objectForKey("prepayid") as! String
    //            self.weChatPayreq.sign = weChatDic.objectForKey("sign") as! String
    //            let timeString = (weChatDic.objectForKey("timestamp") as! String)
    //            let time:UInt32 = UInt32(timeString)!
    //            self.weChatPayreq.timeStamp = time
    //            }, failBlock: { (dic) in
    //
    //        })
    //    }
    
    //    func changePayStatues(notification:NSNotification) {
    ////        viewModel.switchOrderStatus(orderModel.order_id, status: "5", succeccBlock: { (dic) in
    //        let payCompleteVC = Stroyboard("Order", viewControllerId: "PayCompleteViewController") as! PayCompleteViewController
    //        payCompleteVC.orderModel = self.orderModel
    //        self.navigationController?.pushViewController(payCompleteVC, animated: true)
    ////        }) { (dic) in
    ////
    ////        }
    //        NSNotificationCenter.defaultCenter().removeObserver(self, name: WeiXinPayStatues, object: nil)
    //        NSNotificationCenter.defaultCenter().removeObserver(self, name: AliPayStatues, object: nil)
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableOrderFooterView() -> UIView {
        let orderConfirmView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,12))
        orderConfirmView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Pattern_Line")//Pattern_Line
        orderConfirmView.addSubview(imageView)
        return orderConfirmView
    }
    
    
    func tableforFootView() -> UIView {
        let footView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,118))
        footView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,-0.5,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        footView.addSubview(imageView)
        let orderInfo = self.createLabel(CGRectMake(15,20,SCREENWIDTH - 30,14), text: "订单编号：18399939r7")
        footView.addSubview(orderInfo)
        
        let service = self.createLabel(CGRectMake(15,36,SCREENWIDTH - 30,14), text: "订单时间：2016.12.08   12:08:54")
        footView.addSubview(service)
        
        
        let servicePhone = self.createLabel(CGRectMake(15,52,SCREENWIDTH - 30,14), text: "客服电话：400-873-8011")
        footView.addSubview(servicePhone)
        
        
        let serviceTime = self.createLabel(CGRectMake(15,68,SCREENWIDTH - 30,14), text: "客服工作时间：09:00-21:00")
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
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeiFootView(tableView, section: section)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if self.orderType == .orderWaitPay {
                return 170
            }else{
                return 140
            }
        case 1:
            switch indexPath.row {
            case 0:
                return 150
            default:
                return 80
            }
        default:
            switch indexPath.row {
            case 0:
                return 125
            default:
                return 48

            }
        }
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
            if self.orderType == .orderWaitPay {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderWaitePayTableViewCell", forIndexPath: indexPath) as! OrderWaitePayTableViewCell
                cell.selectionStyle = .None
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderDoneTableViewCell", forIndexPath: indexPath) as! OrderDoneTableViewCell
                cell.selectionStyle = .None
                return cell
            }
         case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("TicketDetailInfoTableViewCell", forIndexPath: indexPath) as! TicketDetailInfoTableViewCell
                cell.ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover_02")
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("TicketLocationTableViewCell", forIndexPath: indexPath) as! TicketLocationTableViewCell
                cell.selectionStyle = .None
                return cell
            }
        default:
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderMuchTableViewCell", forIndexPath: indexPath) as! OrderMuchTableViewCell
                cell.selectionStyle = .None
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderPayTableViewCell", forIndexPath: indexPath) as! OrderPayTableViewCell
                cell.selectionStyle = .None
                return cell
            }
        }
    }
}
