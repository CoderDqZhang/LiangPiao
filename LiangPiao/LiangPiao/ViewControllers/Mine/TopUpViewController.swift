//
//  PickUpViewController.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit


class TopUpViewController: UIViewController {

    var tableView:UITableView!
    var viewModel = TopUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "钱包充值"
        self.talKingDataPageName = "钱包充值"
        self.setupForDismissKeyboard()
        self.setUpNavigationItem()
        self.setUpView()
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
        tableView.register(TopUpMuchTableViewCell.self, forCellReuseIdentifier: "TopUpMuchTableViewCell")
        tableView.register(TopUpTypeTableViewCell.self, forCellReuseIdentifier: "TopUpTypeTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.bindViewModel()
        
    }
    
    func bindViewModel(){
        viewModel.controller = self
        //        viewModel.reloadTableView = { _ in
        //            self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
        //        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaultsSetSynchronize("topUp" as AnyObject, key: "PayType")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UserDefaultsSetSynchronize("payOrder" as AnyObject, key: "PayType")
    }
    
    func setUpNavigationItem(){
        self.setNavigationItemBack()
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

}

extension TopUpViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelect(indexPath, controller: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension TopUpViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbrOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TopUpMuchTableViewCell", for: indexPath) as! TopUpMuchTableViewCell
                cell.selectionStyle = .none
                cell.muchTextField.keyboardType = .numberPad
                if viewModel.topUpNumber != nil {
                    cell.muchTextField.text = viewModel.topUpNumber
                    self.viewModel.topUpForm.amount = viewModel.topUpNumber
                }
                cell.muchTextField.reactive.continuousTextValues.observeValues({ (text) in
                    self.viewModel.topUpForm.amount = text
                })
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TopUpTypeTableViewCell", for: indexPath) as! TopUpTypeTableViewCell
                cell.selectionStyle = .none
                viewModel.tableViewTopUpTypeTableViewCell(cell, indexPath:indexPath)
                return cell
            }
        default:
            let cellIndef = "CleanTableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIndef)
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIndef)
                let topUpButton = UIButton(type: .custom)
                topUpButton.setTitleColor(UIColor.white, for: UIControlState())
                topUpButton.setTitle("充值", for: UIControlState())
                topUpButton.backgroundColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
                topUpButton.layer.cornerRadius = 2.0
                topUpButton.layer.masksToBounds = true
                topUpButton.titleLabel?.font = App_Theme_PinFan_M_15_Font
                cell?.contentView.addSubview(topUpButton)
                topUpButton.snp.makeConstraints({ (make) in
                    make.left.equalTo((cell?.contentView.snp.left)!).offset(15)
                    make.right.equalTo((cell?.contentView.snp.right)!).offset(-15)
                    make.top.equalTo((cell?.contentView.snp.top)!).offset(0)
                    make.bottom.equalTo((cell?.contentView.snp.bottom)!).offset(0)
                })
                topUpButton.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: SCREENWIDTH - 30, height: 49))
                topUpButton.reactive.controlEvents(.touchUpInside).observe({ (event) in
                    self.viewModel.requestTopUp()
                })
            }
            cell?.backgroundColor = UIColor.clear
            cell?.contentView.backgroundColor = UIColor.clear
            
            return cell!
        }
    }
}

extension TopUpViewController : UITextFieldDelegate {
    
}

