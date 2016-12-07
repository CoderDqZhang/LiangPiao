//
//  AddAddressViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum AddAddressViewControllerType {
    case EditType
    case AddType
}

typealias ReloadAddressViewClouse = () ->Void

class AddAddressViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = AddressViewModel.shareInstance
    var deleteView:GloableBottomButtonView!
    var cityPickerView:ZHPickView!
    var models:AddressModel?
    var type:AddAddressViewControllerType = .AddType
    
    var cell:GloabTitleAndSwitchBarTableViewCell!
    
    var reloadAddressViewClouse:ReloadAddressViewClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItem()
        self.setupForDismissKeyboard()
        if type == .AddType {
            models = AddressModel.init(fromDictionary: ["address":"","default":false,"id":0,"location":"","mobile_num":"","name":""])
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        if KWINDOWDS?.viewWithTag(2) != nil {
            cityPickerView.remove()
        }
    }
    
    func setUpNavigationItem() {
        if type == .AddType {
            self.navigationItem.title = "新增收货地址"
            self.talKingDataPageName = "新增收货地址"
        }else{
            self.navigationItem.title = "编辑收货地址"
            self.talKingDataPageName = "编辑收货地址"
        }
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: #selector(AddAddressViewController.saveItemBarPress(_:)))
    }
    
    func saveItemBarPress(sender:UIBarButtonItem) {
        viewModel.addressChange(self, type:type, model:models!)
    }

    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.registerClass(DetailAddressTableViewCell.self, forCellReuseIdentifier: "DetailAddressTableViewCell")
        tableView.registerClass(GloabTitleAndSwitchBarTableViewCell.self, forCellReuseIdentifier: "GloabTitleAndSwitchBarTableViewCell")
        self.view.addSubview(tableView)
        if type == .EditType {
            deleteView = GloableBottomButtonView.init(frame: nil, title: "删除收货地址", tag: 1, action: { (tag) in
                UIAlertController.shwoAlertControl(self, title: "确定删除地址吗？", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
                    
                    }, doneAction: {
                        self.viewModel.deleteAddress(self, model: self.models!)
                })
            })
            self.view.addSubview(deleteView)
            tableView.snp_makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, -deleteView.frame.size.height, 0))
            }
            
        }else{
            tableView.snp_makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadAddressView(){
        if reloadAddressViewClouse != nil {
            self.reloadAddressViewClouse()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showCityPickerView(){
        self.view.endEditing(true)
        if cityPickerView == nil {
            cityPickerView = ZHPickView(pickviewWithPlistName: "city", isHaveNavControler: false)
            cityPickerView.setPickViewColer(UIColor.whiteColor())
            cityPickerView.setTintColor(UIColor.whiteColor())
            cityPickerView.tag = 2
            cityPickerView.setToolbarTintColor(UIColor.whiteColor())
            cityPickerView.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            cityPickerView.delegate = self
        }
        cityPickerView.show()
    }

}

extension AddAddressViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 2 {
                self.showCityPickerView()
            }
        default:
            break;
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 3 {
                return 82
            }else{
                return 48
            }
        default:
            return 48
        }
    }
}

extension AddAddressViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0,1:
                let cell =  tableView.dequeueReusableCellWithIdentifier("GloabTitleAndFieldCell", forIndexPath: indexPath) as! GloabTitleAndFieldCell
                cell.selectionStyle = .None
                cell.textField.delegate = self
                cell.textField.tag = indexPath.row
                cell.setData(viewModel.tableViewConfigCell(indexPath), detail: "")
                if type == .EditType {
                    if models != nil {
                        if indexPath.row == 0 {
                            cell.setTextFieldText((models?.name)!)
                            
                        }else{
                            cell.setTextFieldText((models?.mobileNum)!)
                        }
                    }
                }
                if indexPath.row == 0 {
                    cell.textField.rac_textSignal().subscribeNext({ (str) in
                        self.models?.name = str as! String
                    })
                }else{
                    cell.textField.rac_textSignal().subscribeNext({ (str) in
                        self.models?.mobileNum = str as! String
                    })
                }
                return cell
            case 2:
                let cell =  tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                cell.selectionStyle = .None
                cell.setData(viewModel.tableViewConfigCell(indexPath), detail: "未选择")
                if type == .EditType {
                    if models != nil {
                        cell.detailLabel.text = models?.location
                    }
                }
                return cell
            default:
                let cell =  tableView.dequeueReusableCellWithIdentifier("DetailAddressTableViewCell", forIndexPath: indexPath) as! DetailAddressTableViewCell
                cell.textView.delegate = self
                
                if type == .EditType {
                    if models != nil {
                        cell.textView.text = models?.address
                    }
                }
                cell.textView.rac_textSignal().subscribeNext({ (str) in
                    self.models?.address = str as! String
                })
                cell.selectionStyle = .None
                return cell
            }
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndSwitchBarTableViewCell", forIndexPath: indexPath) as! GloabTitleAndSwitchBarTableViewCell
            cell.hidderLineLabel()
            if type == .EditType {
                if models != nil {
                    cell.switchBar.setOn((models?.defaultField)!, animated: true)
                }else{
                    cell.switchBar.setOn(false, animated: true)
                }
            }else{
                if viewModel.addressModels.count == 0 {
                    self.models?.defaultField = true
                    cell.switchBar.setOn(true, animated: true)
                }else{
                    cell.switchBar.setOn(false, animated: true)
                }
            }
            cell.switchBar.rac_signalForControlEvents(.ValueChanged).subscribeNext({ (value) in
                self.models?.defaultField = (value as! UISwitch).on
            })
            cell.selectionStyle = .None
            return cell
        }
    }
}

extension AddAddressViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        if KWINDOWDS?.viewWithTag(2) != nil {
            cityPickerView.remove()
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        if textField.tag == 0 {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: textField.tag + 1, inSection: 0)) as! GloabTitleAndFieldCell
            cell.textField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
            self.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath.init(forRow: textField.tag + 1, inSection: 0))
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension AddAddressViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(pickView: ZHPickView!, resultString: String!) {
        print(resultString)
        if resultString != nil {
            models?.location = resultString
            viewModel.updateCellString(tableView, string: resultString, tag: pickView.tag)
        }
        if pickView.tag == 2 {
            let cell =  tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: pickView.tag + 1, inSection: 0)) as! DetailAddressTableViewCell
            cell.textView.becomeFirstResponder()
        }
    }
}

extension AddAddressViewController : UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if KWINDOWDS?.viewWithTag(2) != nil {
            cityPickerView.remove()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
}

