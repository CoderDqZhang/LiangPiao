//
//  TicketConfirmViewController.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum OrderFormType {
    case withNomal
    case withAddress
    case withOrderStatues
}

class TicketConfirmViewController: UIViewController {

    var orderConfirm:ConfirmView!
    
    var tableView:UITableView!
    var formType:OrderFormType = .withAddress
    var formAddress:NSInteger = 0
    let viewModel = OrderConfirmViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "确认订单"
        self.setUpView()
        self.bindViewModel()
        self.talKingDataPageName = "确认订单"
        // Do any additional setup after loading the view.
    }

    func setUpView() {
        self.setNavigationItemBack()
        
        orderConfirm = ConfirmView(frame: CGRectMake(0, SCREENHEIGHT - 49 - 64, SCREENHEIGHT, 49))
        orderConfirm.payButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            self.navigationController?.pushViewController(OrderDetailViewController(), animated: true)

        }
        
        self.view.addSubview(orderConfirm)
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_TableViewBackGround_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        tableView.registerClass(GloabTitleAndImageCell.self, forCellReuseIdentifier: "GloabTitleAndImageCell")
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.registerClass(GloabTitleAndDetailCell.self, forCellReuseIdentifier: "GloabTitleAndDetailCell")
        tableView.registerClass(CofimTicketTableViewCell.self, forCellReuseIdentifier: "CofimTicketTableViewCell")
        tableView.registerClass(OrderConfirmAddressTableViewCell.self, forCellReuseIdentifier: "OrderConfirmAddressTableViewCell")
        tableView.registerClass(GloabTextFieldCell.self, forCellReuseIdentifier: "GloabTextFieldCell")
        tableView.registerClass(ReciveTableViewCell.self, forCellReuseIdentifier: "ReciveTableViewCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)

        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(-49)
        }

    }
    
    func bindViewModel() {
        viewModel.orderConfirmViewModelClouse = { indexPath in
            if indexPath.section == 0 {
                switch indexPath.row {
                case 1:
                    let controller = AddressViewController()
                    controller.addressType = .addType
                    controller.viewModel.addressType = .addType
                    controller.addressInfoClouse = { name, address in
                        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0)) as! OrderConfirmAddressTableViewCell
                        cell.setData(name, address: address, type: .withAddress)
                    }
                    controller.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(controller, animated: true)
                default:
                    let controller = AddressViewController()
                    controller.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func ticketIntrductView() -> UIView {
        let ticketIntrductView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,67))
        ticketIntrductView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        ticketIntrductView.addSubview(imageView)
        
        let label = self.createLabel(CGRectMake(15,20,200,17), text: "票品售出后不可退换，可转售")
        ticketIntrductView.addSubview(label)
        return ticketIntrductView
    }
    
    func orderConfirmView() -> UIView {
        let orderConfirmView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,105))
        orderConfirmView.backgroundColor = UIColor.init(hexString: Home_Ticket_Introuduct_Back_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Pattern_Line")//Pattern_Line
        orderConfirmView.addSubview(imageView)
        
        if self.formType != .withNomal {
            let address = self.createLabel(CGRectMake(15,20,SCREENWIDTH - 30,17), text: "取票地点：北京市朝阳区香河园小区西坝河中里35号楼二层207")
            orderConfirmView.addSubview(address)
            
            let time = self.createLabel(CGRectMake(15,39,SCREENWIDTH - 30,17), text: "取票时间：周一至周五 08:30 - 20:30")
            orderConfirmView.addSubview(time)
            
            let instroduct = self.createLabel(CGRectMake(15,58,SCREENWIDTH - 30,17), text: "凭手机短信取票码取票，客服热线 400-636-2266")
            orderConfirmView.addSubview(instroduct)
        }
        return orderConfirmView
    }
    
    func upDataTableView() {
        self.tableView.reloadData()
    }
    
    func createLabel(frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = Home_Ticket_Introuduct_Font
        label.textColor = UIColor.init(hexString: Home_Ticket_Introuduct_Color)
        return label
    }

}
extension TicketConfirmViewController : UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.formType == .withAddress {
            if section == 0 {
                return 105
            }else if section == 2 {
                return 67
            }else{
                return 10
            }
        }else{
            if section == 2 {
                return 67
            }else{
                return 10
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 86
            case 1:
                return 52
            default:
                return 52
            }
        case 1:
            switch indexPath.row {
            case 0:
                return 150
            case 4:
                return 52
            default:
                return 48
            }
        default:
            switch indexPath.row {
            case 0:
                return 48
            default:
                return 52
            }
        }
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelect(tableView, indexPath:indexPath)
    }
    
    
}

extension TicketConfirmViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return self.orderConfirmView()
        }else if section == 2 {
            return self.ticketIntrductView()
        }else{
            return nil
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 5
        default:
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("ReciveTableViewCell", forIndexPath: indexPath) as! ReciveTableViewCell
                cell.selectionStyle = .None
                cell.reciveViewClouse = { tag in
                    if tag == 1 {
                        self.formType = .withNomal
                    }else{
                        self.formType = .withAddress
                    }
                    self.formAddress = tag
                    self.upDataTableView()
                }
                return cell
            default:
                if self.formAddress == 3 || self.formAddress == 2 {
                    let cell = tableView.dequeueReusableCellWithIdentifier("GloabTextFieldCell", forIndexPath: indexPath) as! GloabTextFieldCell
                    cell.selectionStyle = .None
                    if indexPath.row == 1 {
                        cell.setData(viewModel.configCellLabel(indexPath), detail: "取票人姓名")
                    }else{
                        cell.setData(viewModel.configCellLabel(indexPath), detail: "取票人手机号码")
                        cell.hideLineLabel()
                    }
                    return cell
                }else{
                    if indexPath.row == 1 {
                        let cell = tableView.dequeueReusableCellWithIdentifier("OrderConfirmAddressTableViewCell", forIndexPath: indexPath) as! OrderConfirmAddressTableViewCell
                        cell.setData("", address: "", type: .withNone)
                        cell.selectionStyle = .None
                        return cell
                    }else{
                        let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                        cell.selectionStyle = .None
                        cell.setData(viewModel.configCellLabel(indexPath), detail: "普通快递（8元）")
                        if indexPath.row == 2 {
                            cell.hideLineLabel()
                        }
                        return cell
                    }
                }
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("CofimTicketTableViewCell", forIndexPath: indexPath) as! CofimTicketTableViewCell
                cell.ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover_02")
                cell.selectionStyle = .None
                return cell
            case 1,3:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailCell", forIndexPath: indexPath) as! GloabTitleAndDetailCell
            
                cell.selectionStyle = .None
                cell.setData(viewModel.configCellLabel(indexPath), detail: "360.00元")
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                cell.selectionStyle = .None
                cell.setData(viewModel.configCellLabel(indexPath), detail: "未选择")
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndFieldCell", forIndexPath: indexPath) as! GloabTitleAndFieldCell
                cell.hideLineLabel()
                cell.selectionStyle = .None
                cell.setData(viewModel.configCellLabel(indexPath), detail: "")
                
                return cell
            }
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndImageCell", forIndexPath: indexPath) as! GloabTitleAndImageCell
            if indexPath.row == 1 {
                cell.hideLineLabel()
                cell.setData(viewModel.configCellLabel(indexPath), isSelect: false)
            }else{
                cell.setData(viewModel.configCellLabel(indexPath), isSelect: true)
            }
            cell.selectionStyle = .None
            
            return cell
        }
    }
}
