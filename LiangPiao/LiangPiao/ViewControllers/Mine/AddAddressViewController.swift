//
//  AddAddressViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = AddAddressViewModel()
    var cityPickerView:ZHPickView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItem()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        if KWINDOWDS?.viewWithTag(2) != nil {
            cityPickerView.remove()
        }
    }
    
    func setUpNavigationItem() {
        self.navigationItem.title = "新增收货地址"
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: #selector(AddAddressViewController.saveItemBarPress(_:)))
    }
    
    func saveItemBarPress(sender:UIBarButtonItem) {
        
    }

    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_TableViewBackGround_Color)
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.registerClass(DetailAddressTableViewCell.self, forCellReuseIdentifier: "DetailAddressTableViewCell")
        tableView.registerClass(SetNomalAddressTableViewCell.self, forCellReuseIdentifier: "SetNomalAddressTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
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
    
    func showCityPickerView(){
        self.view.endEditing(true)
        if cityPickerView == nil {
            cityPickerView = ZHPickView(pickviewWithPlistName: "city", isHaveNavControler: false)
            cityPickerView.setPickViewColer(UIColor.whiteColor())
            cityPickerView.setTintColor(UIColor.whiteColor())
            cityPickerView.tag = 2
            cityPickerView.setToolbarTintColor(UIColor.whiteColor())
            cityPickerView.setTintFont(Mine_Service_Font, color: UIColor.init(hexString: App_Theme_Text_Color))
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
                return cell
            case 2:
                let cell =  tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                cell.selectionStyle = .None
                cell.setData(viewModel.tableViewConfigCell(indexPath), detail: "请选择")
                return cell
            default:
                let cell =  tableView.dequeueReusableCellWithIdentifier("DetailAddressTableViewCell", forIndexPath: indexPath) as! DetailAddressTableViewCell
                cell.textView.delegate = self
                cell.selectionStyle = .None
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("SetNomalAddressTableViewCell", forIndexPath: indexPath) as! SetNomalAddressTableViewCell
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
        if resultString != nil {
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

