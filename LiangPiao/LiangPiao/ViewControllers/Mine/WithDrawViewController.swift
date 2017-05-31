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
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(WithDrawTableViewCell.self, forCellReuseIdentifier: "WithDrawTableViewCell")
        tableView.register(GloabTitleAndFieldCell.self, forCellReuseIdentifier: "GloabTitleAndFieldCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
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
        let topUpFooterView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH,height: 105))
        topUpFooterView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        let aboutTopUp = self.createLabel(CGRect(x: 15,y: 20,width: SCREENWIDTH - 30,height: 17), text: "目前仅支持支付宝提现")
        topUpFooterView.addSubview(aboutTopUp)
        
        let aboutTopUpMineMuch = self.createLabel(CGRect(x: 15,y: 39,width: SCREENWIDTH - 30,height: 17), text: "提现免费，单笔提现金额不小于 50 元")
        topUpFooterView.addSubview(aboutTopUpMineMuch)
        
        let aboutTopTime = self.createLabel(CGRect(x: 15,y: 58,width: SCREENWIDTH - 30,height: 17), text: "提现到账时间为 3 - 5 个工作日，节假日顺延")
        topUpFooterView.addSubview(aboutTopTime)
        return topUpFooterView
    }
    
    func createLabel(_ frame:CGRect, text:String) -> UILabel {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        viewModel.mySellOrderTableViewDidSelect(indexPath, controller: self.viewModel.controller)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension WithDrawViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 102
        }
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return self.topUpFooterView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WithDrawTableViewCell", for: indexPath) as! WithDrawTableViewCell
                cell.muchTextField.tag = indexPath.row
                cell.muchTextField.delegate = self
                cell.muchTextField.keyboardType = .numberPad
                cell.setPlachText(viewModel.maxMuch)
                cell.muchTextField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
                cell.muchTextField.reactive.continuousTextValues.observeValues({ (str) in
                    self.viewModel.form.amount = str!
                })
                cell.withDrawTableViewCellClouse =  { _ in
                    self.viewModel.form.amount = self.viewModel.maxMuch
                    cell.muchTextField.text = self.viewModel.maxMuch
                }
                cell.selectionStyle = .none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndFieldCell", for: indexPath) as! GloabTitleAndFieldCell
                cell.setData(viewModel.cellTitle(indexPath), detail: "")
                cell.textField.textColor = UIColor.init(hexString: App_Theme_8A96A2_Color)
                cell.textField.returnKeyType = .next
                cell.textField.textColor = UIColor.init(hexString: App_Theme_384249_Color)
                cell.textField.keyboardType = .emailAddress
                if indexPath.row == 1 {
                    cell.textField.keyboardType = .namePhonePad
                }
                if indexPath.row == 0 {
                    if UserDefaultsGetSynchronize("aliPayCount") as! String != "nil" {
                        cell.textField.text = UserDefaultsGetSynchronize("aliPayCount") as? String
                        self.viewModel.form.aliPayCount = (UserDefaultsGetSynchronize("aliPayCount") as? String)!
                    }
                    cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                        self.viewModel.form.aliPayCount = str!
                    })
                }else{
                    if UserDefaultsGetSynchronize("aliPayName") as! String != "nil" {
                        cell.textField.text = UserDefaultsGetSynchronize("aliPayName") as? String
                        self.viewModel.form.aliPayName = (UserDefaultsGetSynchronize("aliPayName") as? String)!
                    }
                    cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                        self.viewModel.form.aliPayName = str!
                    })
                }
                cell.textField.tag = indexPath.row
                cell.textField.textAlignment = .left
                cell.textField.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        default:
            let cellIndef = "CleanTableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIndef)
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIndef)
                let topUpButton = CustomButton.init(frame: CGRect.init(x: 15 , y: 0, width: SCREENWIDTH - 30, height: 49), title: "提现", tag: 1, titleFont: App_Theme_PinFan_M_15_Font!, type: .withBackBoarder) { (tag) in
                    self.viewModel.requestWithDraw(self.viewModel.form)
                }
                cell?.contentView.addSubview(topUpButton)
            }
            cell?.backgroundColor = UIColor.clear
            cell?.contentView.backgroundColor = UIColor.clear
            
            return cell!
        }
    }
}

extension WithDrawViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0  {
            let cell = tableView.cellForRow(at: IndexPath.init(row: textField.tag + 1, section: 0)) as! GloabTitleAndFieldCell
            cell.textField.becomeFirstResponder()
        }else if textField.tag == 1 {
            let cell = tableView.cellForRow(at: IndexPath.init(row: textField.tag + 1, section: 0)) as! WithDrawTableViewCell
            cell.muchTextField.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        return true
    }
    
}
