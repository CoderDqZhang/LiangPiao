//
//  WithDrawViewController.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class WithDrawViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = WithDrawViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "提现"
        self.talKingDataPageName = "提现"
        self.setUpNavigationItem()
        self.setUpView()
        self.setupForDismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.registerClass(WithDrawTableViewCell.self, forCellReuseIdentifier: "WithDrawTableViewCell")
        tableView.registerClass(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.bindViewModel()
        
    }
    
    func bindViewModel(){
        viewModel.controller = self
        
    }
    
    func setUpNavigationItem(){
        self.setNavigationItemBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func topUpFooterView() -> UIView {
        let topUpFooterView = UIView(frame: CGRectMake(0,0,SCREENWIDTH,105))
        topUpFooterView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let aboutTopUp = self.createLabel(CGRectMake(15,20,SCREENWIDTH - 30,17), text: "目前仅支持支付宝提现")
        topUpFooterView.addSubview(aboutTopUp)
        
        let aboutTopUpMineMuch = self.createLabel(CGRectMake(15,39,SCREENWIDTH - 30,17), text: "提现免费，单笔提现金额不小于 50 元")
        topUpFooterView.addSubview(aboutTopUpMineMuch)
        
        let aboutTopTime = self.createLabel(CGRectMake(15,58,SCREENWIDTH - 30,17), text: "提现到账时间为 3 - 5 个工作日，节假日顺延")
        topUpFooterView.addSubview(aboutTopTime)
        return topUpFooterView
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
    
}

extension WithDrawViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        viewModel.mySellOrderTableViewDidSelect(indexPath, controller: self.viewModel.controller)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}

extension WithDrawViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 102
        }
        return 0.000001
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return self.topUpFooterView()
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("WithDrawTableViewCell", forIndexPath: indexPath) as! WithDrawTableViewCell
                cell.muchTextField.tag = indexPath.row
                cell.muchTextField.delegate = self
                cell.setPlachText(viewModel.maxMuch)
                cell.muchTextField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
                cell.muchTextField.rac_textSignal().subscribeNext({ (str) in
                    self.viewModel.form.amount = str as! String
                })
                cell.withDrawTableViewCellClouse =  { _ in
                    cell.muchTextField.text = self.viewModel.maxMuch
                }
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndFieldCell", forIndexPath: indexPath) as! GloabTitleAndFieldCell
                cell.setData(viewModel.cellTitle(indexPath), detail: "")
                cell.textField.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
                cell.textField.returnKeyType = .Next
                cell.textField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
                cell.textField.keyboardType = .EmailAddress
                if indexPath.row == 1 {
                    cell.textField.keyboardType = .NamePhonePad
                }
                if indexPath.row == 0 {
                    if UserDefaultsGetSynchronize("aliPayCount") as! String != "nil" {
                        cell.textField.text = UserDefaultsGetSynchronize("aliPayCount") as? String
                    }
                    cell.textField.rac_textSignal().subscribeNext({ (str) in
                        self.viewModel.form.aliPayCount = str as! String
                    })
                }else{
                    if UserDefaultsGetSynchronize("aliPayName") as! String != "nil" {
                        cell.textField.text = UserDefaultsGetSynchronize("aliPayName") as? String
                    }
                    cell.textField.rac_textSignal().subscribeNext({ (str) in
                        self.viewModel.form.aliPayName = str as! String
                    })
                }
                cell.textField.tag = indexPath.row
                cell.textField.textAlignment = .Left
                cell.textField.delegate = self
                cell.selectionStyle = .None
                return cell
            }
        default:
            let cellIndef = "CleanTableViewCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIndef)
            if cell == nil {
                cell = UITableViewCell.init(style: .Default, reuseIdentifier: cellIndef)
                let topUpButton = CustomButton.init(frame: CGRect.init(x: 15 , y: 0, width: SCREENWIDTH - 30, height: 49), title: "提现", tag: nil, titleFont: App_Theme_PinFan_M_15_Font!, type: .withBackBoarder) { (tag) in
                    self.viewModel.requestWithDraw(self.viewModel.form)
                }
                cell?.contentView.addSubview(topUpButton)
            }
            cell?.backgroundColor = UIColor.clearColor()
            cell?.contentView.backgroundColor = UIColor.clearColor()
            
            return cell!
        }
    }
}

extension WithDrawViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == 0  {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: textField.tag + 1, inSection: 0)) as! GloabTitleAndFieldCell
            cell.textField.becomeFirstResponder()
        }else if textField.tag == 1 {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: textField.tag + 1, inSection: 0)) as! WithDrawTableViewCell
            cell.muchTextField.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        return true
    }
    
}
