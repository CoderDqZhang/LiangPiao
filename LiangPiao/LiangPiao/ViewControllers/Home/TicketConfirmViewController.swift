//
//  TicketConfirmViewController.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveSwift

class TicketConfirmViewController: UIViewController {

    var orderConfirm:ConfirmView!
    
    var tableView:UITableView!
    let viewModel = OrderConfirmViewModel()
    var expressage:ZHPickView!
    
    var muchOfTicket:Disposable!
    
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
            let typeArray = viewModel.ticketModel.deliveryType.components(separatedBy: ",")
            let array = NSMutableArray.init(array: [])
            for index in typeArray {
                if index == "1" {
                    array.add("普通快递（\((viewModel.ticketModel.deliveryPrice)!)元")
                    array.add("顺丰快递（\((viewModel.ticketModel.deliveryPriceSf)!)元)")
                }else if index == "4" {
                    array.add("快递到付")
                }
            }
            expressage = ZHPickView(pickviewWith: array as [AnyObject], isHaveNavControler: false)
            expressage.setPickViewColer(UIColor.white)
            expressage.setPickViewColer(UIColor.white)
            expressage.setTintColor(UIColor.white)
            expressage.tag = 1
            expressage.setToolbarTintColor(UIColor.white)
            expressage.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            expressage.delegate = self
        }
        
        expressage.show()
    }
    
    func setUpView() {
        self.setNavigationItemBack()
        
        orderConfirm = ConfirmView(frame: CGRect(x: 0, y: SCREENHEIGHT - 49 - 64, width: SCREENHEIGHT, height: 49))
        orderConfirm.payButton.reactive.controlEvents(.touchUpInside).observe { (action) in            
            self.viewModel.createOrder()
        }
        
        viewModel.reactive.producer(forKeyPath: "muchOfTicketWithOther").start { (event) in
            self.orderConfirm.setMuchLabelText(("\((event.value as? String)!)"))
        }
        
        self.view.addSubview(orderConfirm)
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.register(DetailAddressTableViewCell.self, forCellReuseIdentifier: "DetailAddressTableViewCell")
        tableView.register(GloabTitleAndImageCell.self, forCellReuseIdentifier: "GloabTitleAndImageCell")
        tableView.register(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.register(GloabTitleAndDetailCell.self, forCellReuseIdentifier: "GloabTitleAndDetailCell")
        tableView.register(CofimTicketTableViewCell.self, forCellReuseIdentifier: "CofimTicketTableViewCell")
        tableView.register(OrderConfirmAddressTableViewCell.self, forCellReuseIdentifier: "OrderConfirmAddressTableViewCell")
        tableView.register(GloabTextFieldCell.self, forCellReuseIdentifier: "GloabTextFieldCell")
        tableView.register(TicketNumberTableViewCell.self, forCellReuseIdentifier: "TicketNumberTableViewCell")
        tableView.register(ReciveTableViewCell.self, forCellReuseIdentifier: "ReciveTableViewCell")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-49)
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
                            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
                            let cell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! OrderConfirmAddressTableViewCell
                            cell.setData(model, type: .withAddress)
                            
                        }
                        
                        controller.reloadConfigTableView = { _ in
                            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
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
        let ticketIntrductView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 67))
        ticketIntrductView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let imageView = UIImageView(frame:CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 4))
        imageView.image = UIImage.init(named: "Sawtooth")//Pattern_Line
        ticketIntrductView.addSubview(imageView)
        
        let label = self.createLabel(CGRect(x: 15,y: 20,width: 200,height: 17), text: "票品售出后不可退换，可转售")
        ticketIntrductView.addSubview(label)
        return ticketIntrductView
    }
    
    func orderConfirmView() -> UIView {
        let orderConfirmView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 105))
        orderConfirmView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
//        let imageView = UIImageView(frame:CGRectMake(0,0,SCREENWIDTH,4))
//        imageView.image = UIImage.init(named: "Pattern_Line")//Pattern_Line
//        orderConfirmView.addSubview(imageView)
        
        if viewModel.formType != .withNomal {
            let address = self.createLabel(CGRect(x: 15,y: 20,width: SCREENWIDTH - 30,height: 17), text: "取票地点：\((viewModel.ticketModel.sceneGetTicketAddress)!)")
            orderConfirmView.addSubview(address)
            
            let time = self.createLabel(CGRect(x: 15,y: 39,width: SCREENWIDTH - 30,height: 17), text: "取票时间：\((viewModel.ticketModel.sceneGetTicketDate)!)")
            orderConfirmView.addSubview(time)
            
            let instroduct = self.createLabel(CGRect(x: 15,y: 58,width: SCREENWIDTH - 30,height: 17), text: "客服热线：400-873-8011")
            orderConfirmView.addSubview(instroduct)
            
        }
        return orderConfirmView
    }
    
    func upDataTableView() {
        self.tableView.reloadData()
    }
    
    func createLabel(_ frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = App_Theme_PinFan_R_12_Font
        label.textColor = UIColor.init(hexString: App_Theme_BBC1CB_Color)
        return label
    }

}
extension TicketConfirmViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeightForFooterInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(tableView,indexPath:indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelect(tableView, indexPath:indexPath)
    }
}

extension TicketConfirmViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return self.orderConfirmView()
        }else if section == 2 {
            return self.ticketIntrductView()
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReciveTableViewCell", for: indexPath) as! ReciveTableViewCell
                cell.selectionStyle = .none
                viewModel.tableViewCellReciveTableViewCell(cell)
                return cell
            default:
                if viewModel.formType == .withAddress {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTextFieldCell", for: indexPath) as! GloabTextFieldCell
                    cell.selectionStyle = .none
                    cell.textField.delegate = self
                    cell.textField.tag = indexPath.row
                    if indexPath.row == 1 {
                        cell.setData(viewModel.configCellLabel(indexPath), detail: "取票人姓名")
                        cell.textField.reactive.continuousTextValues.observeValues({ (text) in
                            self.viewModel.orderForme.name = text!
                        })
                        cell.textField.keyboardType = .namePhonePad
                        cell.textField.returnKeyType = .next
                    }else{
                        cell.setData(viewModel.configCellLabel(indexPath), detail: "取票人手机号码")
                        cell.textField.reactive.continuousTextValues.observeValues({ (text) in
                            self.viewModel.orderForme.phone = text!
                        })
                        cell.textField.keyboardType = .phonePad
                        cell.hideLineLabel()
                    }
                    return cell
                }else{
                    if indexPath.row == 1 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderConfirmAddressTableViewCell", for: indexPath) as! OrderConfirmAddressTableViewCell
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
                        cell.selectionStyle = .none
                        return cell
                    }else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailImageCell", for: indexPath) as! GloabTitleAndDetailImageCell
                        cell.selectionStyle = .none
                        let typeArray = viewModel.ticketModel.deliveryType.components(separatedBy: ",")
                        for index in typeArray {
                            if index == "1" {
                                cell.setData(viewModel.configCellLabel(indexPath), detail: "普通快递（\((viewModel.ticketModel.deliveryPrice)!)元）")
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "CofimTicketTableViewCell", for: indexPath) as! CofimTicketTableViewCell
                viewModel.tableViewCellCofimTicketTableViewCell(cell)
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TicketNumberTableViewCell", for: indexPath) as! TicketNumberTableViewCell
                viewModel.configCellTicketNumberTableViewCell(cell)
                cell.selectionStyle = .none
                return cell
            case 2,4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailCell", for: indexPath) as! GloabTitleAndDetailCell
                cell.selectionStyle = .none
                viewModel.tableViewCellGloabTitleAndDetailCell(cell, indexPath:indexPath)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailImageCell", for: indexPath) as! GloabTitleAndDetailImageCell
                cell.selectionStyle = .none
                cell.setData(viewModel.configCellLabel(indexPath), detail: "无可用")
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailAddressTableViewCell", for: indexPath) as! DetailAddressTableViewCell
                cell.textView.delegate = self
                cell.selectionStyle = .none
                cell.setPlaceholerText("备注：如配单、代发快递等")
                return cell
            }
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndImageCell", for: indexPath) as! GloabTitleAndImageCell
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
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
extension TicketConfirmViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(_ pickView: ZHPickView!, resultString: String!) {
        if resultString != nil {
            viewModel.updateCellString(tableView, string: resultString)
        }
    }
}

extension TicketConfirmViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        return true
    }
}

extension TicketConfirmViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        self.viewModel.orderForme.message = "\(textView.text)\(text)"
        return true
    }
}
