//
//  AddAddressViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum AddAddressViewControllerType {
    case editType
    case addType
}

typealias ReloadAddressViewClouse = () ->Void

class AddAddressViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = AddressViewModel.shareInstance
    var deleteView:GloableBottomButtonView!
    var cityPickerView:ZHPickView!
    var models:AddressModel?
    var type:AddAddressViewControllerType = .addType
    
    var cell:GloabTitleAndSwitchBarTableViewCell!
    
    var reloadAddressViewClouse:ReloadAddressViewClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItem()
        self.setupForDismissKeyboard()
        if type == .addType {
            models = AddressModel.init(fromDictionary: ["address":"","default":false,"id":0,"location":"","mobile_num":"","name":""])
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if KWINDOWDS().viewWithTag(2) != nil {
            cityPickerView.remove()
        }
    }
    
    func setUpNavigationItem() {
        if type == .addType {
            self.navigationItem.title = "新增收货地址"
            self.talKingDataPageName = "新增收货地址"
        }else{
            self.navigationItem.title = "编辑收货地址"
            self.talKingDataPageName = "编辑收货地址"
        }
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(AddAddressViewController.saveItemBarPress(_:)))
    }
    
    func saveItemBarPress(_ sender:UIBarButtonItem) {
        viewModel.addressChange(self, type:type, model:models!)
    }

    func setUpView() {
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.register(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.register(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.register(DetailAddressTableViewCell.self, forCellReuseIdentifier: "DetailAddressTableViewCell")
        tableView.register(GloabTitleAndSwitchBarTableViewCell.self, forCellReuseIdentifier: "GloabTitleAndSwitchBarTableViewCell")
        self.view.addSubview(tableView)
        if type == .editType {
            deleteView = GloableBottomButtonView.init(frame: nil, title: "删除收货地址", tag: 1, action: { (tag) in
                UIAlertController.shwoAlertControl(self, style: .alert, title: "确定删除地址吗？", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
                    
                    }, doneAction: {
                        self.viewModel.deleteAddress(self, model: self.models!)
                })
            })
            self.view.addSubview(deleteView)
            tableView.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, -deleteView.frame.size.height, 0))
            }
            
        }else{
            tableView.snp.makeConstraints { (make) in
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
            cityPickerView.setPickViewColer(UIColor.white)
            cityPickerView.setTintColor(UIColor.white)
            cityPickerView.tag = 2
            cityPickerView.setToolbarTintColor(UIColor.white)
            cityPickerView.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_384249_Color))
            cityPickerView.delegate = self
        }
        cityPickerView.show()
    }

}

extension AddAddressViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 2 {
                self.showCityPickerView()
            }
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0,1:
                let cell =  tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndFieldCell", for: indexPath) as! GloabTitleAndFieldCell
                cell.selectionStyle = .none
                
                cell.textField.delegate = self
                cell.textField.tag = indexPath.row
                cell.setData(viewModel.tableViewConfigCell(indexPath), detail: "")
                if type == .editType {
                    if models != nil {
                        if indexPath.row == 0 {
                            cell.setTextFieldText((models?.name)!)
                            
                        }else{
                            cell.setTextFieldText((models?.mobileNum)!)
                        }
                    }
                }
                if indexPath.row == 0 {
                    cell.textField.keyboardType = .namePhonePad
                    cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                        self.models?.name = str!
                    })
                }else{
                    cell.textField.keyboardType = .phonePad
                    cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                        self.models?.mobileNum = str!
                    })
                }
                return cell
            case 2:
                let cell =  tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailImageCell", for: indexPath) as! GloabTitleAndDetailImageCell
                cell.selectionStyle = .none
                cell.setData(viewModel.tableViewConfigCell(indexPath), detail: "未选择")
                if type == .editType {
                    if models != nil {
                        cell.detailLabel.text = models?.location
                    }
                }
                return cell
            default:
                let cell =  tableView.dequeueReusableCell(withIdentifier: "DetailAddressTableViewCell", for: indexPath) as! DetailAddressTableViewCell
                cell.textView.delegate = self
                
                if type == .editType {
                    if models != nil {
                        cell.textView.text = models?.address
                    }
                }
                cell.textView.reactive.continuousTextValues.observeValues({ (str) in
                    self.models?.address = str!
                })
                cell.selectionStyle = .none
                return cell
            }
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndSwitchBarTableViewCell", for: indexPath) as! GloabTitleAndSwitchBarTableViewCell
            cell.hidderLineLabel()
            if type == .editType {
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
            cell.switchBar.reactive.controlEvents(.valueChanged).observe({ (value) in
                self.models?.defaultField = value.value?.isOn
            })
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension AddAddressViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if KWINDOWDS().viewWithTag(2) != nil {
            cityPickerView.remove()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if textField.tag == 0 {
            let cell = tableView.cellForRow(at: IndexPath.init(row: textField.tag + 1, section: 0)) as! GloabTitleAndFieldCell
            cell.textField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
            self.tableView(tableView, didSelectRowAt: IndexPath.init(row: textField.tag + 1, section: 0))
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension AddAddressViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(_ pickView: ZHPickView!, resultString: String!) {
        print(resultString)
        if resultString != nil {
            models?.location = resultString
            viewModel.updateCellString(tableView, string: resultString, tag: pickView.tag)
        }
        if pickView.tag == 2 {
            let cell =  tableView.cellForRow(at: IndexPath.init(row: pickView.tag + 1, section: 0)) as! DetailAddressTableViewCell
            cell.textView.becomeFirstResponder()
        }
    }
}

extension AddAddressViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if KWINDOWDS().viewWithTag(2) != nil {
            cityPickerView.remove()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
}

