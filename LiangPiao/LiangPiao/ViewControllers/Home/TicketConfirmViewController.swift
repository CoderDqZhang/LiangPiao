//
//  TicketConfirmViewController.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TicketConfirmViewController: UIViewController {

    var orderConfirm:ConfirmView!
    
    var tableView:UITableView!
    let viewModel = OrderConfirmViewModel()
    var expressage:ZHPickView!
    
    var muchOfTicket:RACDisposable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "确认订单"
        self.setUpView()
        self.bindViewModel()
        self.talKingDataPageName = "确认订单"
        self.setupForDismissKeyboard()
        // Do any additional setup after loading the view.
    }

    deinit {
        muchOfTicket = nil
    }
    
    func showExpressagePickerView(){
        if expressage == nil {
            let typeArray = viewModel.ticketModel.deliveryType.componentsSeparatedByString(",")
            let array = NSMutableArray.init(array: [])
            for index in typeArray {
                if index == "1" {
                    array.addObject("普通快递（\(viewModel.ticketModel.deliveryPrice)元")
                    array.addObject("顺丰快递（\(viewModel.ticketModel.deliveryPriceSf)元)")
                }else if index == "4" {
                    array.addObject("快递到付")
                }
            }
            expressage = ZHPickView(pickviewWithArray: array as [AnyObject], isHaveNavControler: false)
            expressage.setPickViewColer(UIColor.whiteColor())
            expressage.setPickViewColer(UIColor.whiteColor())
            expressage.setTintColor(UIColor.whiteColor())
            expressage.tag = 1
            expressage.setToolbarTintColor(UIColor.whiteColor())
            expressage.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            expressage.delegate = self
        }
        
        expressage.show()
    }
    
    func setUpView() {
        self.setNavigationItemBack()
        
        orderConfirm = ConfirmView(frame: CGRectMake(0, SCREENHEIGHT - 49 - 64, SCREENHEIGHT, 49))
        orderConfirm.payButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in            
            self.viewModel.createOrder()
        }
        
        muchOfTicket = viewModel.rac_observeKeyPath("muchOfTicketWithOther", options: .New, observer: self) { (object, objects, new, old) in
            self.orderConfirm.setMuchLabelText(("\((object as? String)!)"))
        }
        
        self.view.addSubview(orderConfirm)
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(DetailAddressTableViewCell.self, forCellReuseIdentifier: "DetailAddressTableViewCell")
        tableView.registerClass(GloabTitleAndImageCell.self, forCellReuseIdentifier: "GloabTitleAndImageCell")
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.registerClass(GloabTitleAndDetailCell.self, forCellReuseIdentifier: "GloabTitleAndDetailCell")
        tableView.registerClass(CofimTicketTableViewCell.self, forCellReuseIdentifier: "CofimTicketTableViewCell")
        tableView.registerClass(OrderConfirmAddressTableViewCell.self, forCellReuseIdentifier: "OrderConfirmAddressTableViewCell")
        tableView.registerClass(GloabTextFieldCell.self, forCellReuseIdentifier: "GloabTextFieldCell")
        tableView.registerClass(TicketNumberTableViewCell.self, forCellReuseIdentifier: "TicketNumberTableViewCell")
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
        viewModel.controller = self
        viewModel.orderConfirmViewModelClouse = { indexPath in
            if indexPath.section == 0 {
                switch indexPath.row {
                case 1:
                    if UserInfoModel.isLoggedIn() {
                        let controller = AddressViewController()
                        controller.addressType = .addType
                        if self.viewModel.addressModel != nil {
                            controller.viewModel.selectModel = self.viewModel.addressModel
                        }
                        controller.viewModel.addressType = .addType
                        controller.addressInfoClouse = { model in
                            self.viewModel.addressModel = model
                            self.viewModel.orderForme.addressId = model.id
                            self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
                            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0)) as! OrderConfirmAddressTableViewCell
                            cell.setData(model, type: .withAddress)
                            
                        }
                        
                        controller.reloadConfigTableView = { _ in
                            self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
                        }
                        
                        controller.hidesBottomBarWhenPushed = true
                        NavigationPushView(self, toConroller: controller)
                    }else{
                        NavigationPushView(self, toConroller: LoginViewController())
                    }
                case 2:
                    self.showExpressagePickerView()
                default:
                    break;
                }
            }else{
                if indexPath.row == 3 {
                    NavigationPushView(self, toConroller: DiscountViewController())
                }
            }
        }
        viewModel.updateMuchOfTicke()
        viewModel.orderForme.remainCount = viewModel.remainCount
        viewModel.orderForme.ticketID = viewModel.ticketModel.id
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
        ticketIntrductView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        ticketIntrductView.addSubview(imageView)
        
        let label = self.createLabel(CGRectMake(15,20,200,17), text: "票品售出后不可退换，可转售")
        ticketIntrductView.addSubview(label)
        return ticketIntrductView
    }
    
    func orderConfirmView() -> UIView {
        let orderConfirmView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,105))
        orderConfirmView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
//        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
//        imageView.image = UIImage.init(named: "Pattern_Line")//Pattern_Line
//        orderConfirmView.addSubview(imageView)
        
        if viewModel.formType != .withNomal {
            let address = self.createLabel(CGRectMake(15,20,SCREENWIDTH - 30,17), text: "取票地点：\(viewModel.ticketModel.sceneGetTicketAddress)")
            orderConfirmView.addSubview(address)
            
            let time = self.createLabel(CGRectMake(15,39,SCREENWIDTH - 30,17), text: "取票时间：\(viewModel.ticketModel.sceneGetTicketDate)")
            orderConfirmView.addSubview(time)
            
            let instroduct = self.createLabel(CGRectMake(15,58,SCREENWIDTH - 30,17), text: "客服热线：400-873-8011")
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
        label.font = App_Theme_PinFan_R_12_Font
        label.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        return label
    }

}
extension TicketConfirmViewController : UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeightForFooterInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(tableView,indexPath:indexPath)
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
        return viewModel.tableViewNumberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("ReciveTableViewCell", forIndexPath: indexPath) as! ReciveTableViewCell
                cell.selectionStyle = .None
                viewModel.tableViewCellReciveTableViewCell(cell)
                return cell
            default:
                if viewModel.formType == .withAddress {
                    let cell = tableView.dequeueReusableCellWithIdentifier("GloabTextFieldCell", forIndexPath: indexPath) as! GloabTextFieldCell
                    cell.selectionStyle = .None
                    cell.textField.delegate = self
                    cell.textField.tag = indexPath.row
                    if indexPath.row == 1 {
                        cell.setData(viewModel.configCellLabel(indexPath), detail: "取票人姓名")
                        cell.textField.rac_textSignal().subscribeNext({ (action) in
                            self.viewModel.orderForme.name = action as? String
                        })
                        cell.textField.keyboardType = .NamePhonePad
                        cell.textField.returnKeyType = .Next
                    }else{
                        cell.setData(viewModel.configCellLabel(indexPath), detail: "取票人手机号码")
                        cell.textField.rac_textSignal().subscribeNext({ (action) in
                            self.viewModel.orderForme.phone = action as? String
                        })
                        cell.textField.keyboardType = .PhonePad
                        cell.hideLineLabel()
                    }
                    return cell
                }else{
                    if indexPath.row == 1 {
                        let cell = tableView.dequeueReusableCellWithIdentifier("OrderConfirmAddressTableViewCell", forIndexPath: indexPath) as! OrderConfirmAddressTableViewCell
                        if UserInfoModel.isLoggedIn() && AddressModel.haveAddress() {
                            let addressModels = AddressModel.unarchiveObjectWithFile()
                            if addressModels.count > 0 && !viewModel.isHaveModel {
                                let model = addressModels[0]
                                viewModel.orderForme.addressId = model.id
                                cell.setData(model, type: .withAddress)
                                viewModel.addressModel = model
                                viewModel.isHaveModel = true
                            }
                        }
                        cell.selectionStyle = .None
                        return cell
                    }else{
                        let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                        cell.selectionStyle = .None
                        let typeArray = viewModel.ticketModel.deliveryType.componentsSeparatedByString(",")
                        for index in typeArray {
                            if index == "1" {
                                cell.setData(viewModel.configCellLabel(indexPath), detail: "普通快递（\(viewModel.ticketModel.deliveryPrice)元）")
                                self.viewModel.delivityType = .delivityNomal
                                break;
                            }else if index == "4" {
                                cell.setData(viewModel.configCellLabel(indexPath), detail: "快递到付")
                                self.viewModel.delivityType = .delivityVisite
                                break;
                            }
                        }
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
                viewModel.tableViewCellCofimTicketTableViewCell(cell)
                cell.selectionStyle = .None
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("TicketNumberTableViewCell", forIndexPath: indexPath) as! TicketNumberTableViewCell
                viewModel.configCellTicketNumberTableViewCell(cell)
                cell.selectionStyle = .None
                return cell
            case 2,4:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailCell", forIndexPath: indexPath) as! GloabTitleAndDetailCell
                cell.selectionStyle = .None
                viewModel.tableViewCellGloabTitleAndDetailCell(cell, indexPath:indexPath)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                cell.selectionStyle = .None
                cell.setData(viewModel.configCellLabel(indexPath), detail: "无可用")
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("DetailAddressTableViewCell", forIndexPath: indexPath) as! DetailAddressTableViewCell
                cell.textView.delegate = self
                cell.selectionStyle = .None
                cell.setPlaceholerText("备注关于本次交易的特别说明")
                return cell
            }
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndImageCell", forIndexPath: indexPath) as! GloabTitleAndImageCell
            if WXApi.isWXAppInstalled() {
                if indexPath.row == 1 {
                    cell.hideLineLabel()
                    if viewModel.orderForme.payType == .aliPay {
                        cell.setData(viewModel.configCellLabel(indexPath), isSelect: true)
                    }else{
                        cell.setData(viewModel.configCellLabel(indexPath), isSelect: false)
                    }
                    
                }else{
                    if viewModel.orderForme.payType == .weiChat {
                        cell.setData(viewModel.configCellLabel(indexPath), isSelect: true)
                    }else{
                        cell.setData(viewModel.configCellLabel(indexPath), isSelect: false)
                    }
                }
            }else{
                viewModel.orderForme.payType = .aliPay
                cell.setData(viewModel.configCellLabel(indexPath), isSelect: true)
                cell.hideLineLabel()
            }
            
            cell.selectionStyle = .None
            
            return cell
        }
    }
}
extension TicketConfirmViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(pickView: ZHPickView!, resultString: String!) {
        if resultString != nil {
            viewModel.updateCellString(tableView, string: resultString)
        }
    }
}

extension TicketConfirmViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        return true
    }
}

extension TicketConfirmViewController : UITextViewDelegate {
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        self.viewModel.orderForme.message = "\(textView.text)\(text)"
        return true
    }
}
