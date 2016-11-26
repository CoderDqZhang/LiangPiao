//
//  AddressViewController.swift
//  LiangPiao
//
//  Created by Zhang on 05/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
enum AddressType {
    case addType
    case editType
}

typealias AddressInfoClouse = (name:String, address:String) -> Void

class AddressViewController: UIViewController {

    var tableView:UITableView!
    var addAddressView:AddAddressView!
    var viewModel = AddressViewModel()
    var addressType:AddressType!
    
    var addressInfoClouse:AddressInfoClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigationItem()
        self.talKingDataPageName = "收货地址管理"
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationItem() {
        self.navigationItem.title = "收货地址管理"
        self.setNavigationItemBack()
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerClass(AddressTableViewCell.self, forCellReuseIdentifier: "AddressTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, -49, 0))
        }
        
        addAddressView = AddAddressView()
        addAddressView.rac_signalForSelector( #selector(AddAddressView.singTapPress(_:))).subscribeNext { (action) in
            let editAddress = AddAddressViewController()
            editAddress.reloadAddressViewClouse = { _ in
                self.reloadData()
            }
            NavigationPushView(self, toConroller: editAddress)
        }
        self.view.addSubview(addAddressView)
        
        addAddressView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.height.equalTo(49)
        }
        
        self.bindViewModle()
    }

    func bindViewModle(){
        viewModel.rac_signalForSelector(#selector(AddressViewModel.tableViewDidSelectIndexPath(_:indexPath:controller:))).subscribeNext { (action) in
        }
        
        viewModel.addressTableViewSelect = { indexPath in
            if self.addressInfoClouse != nil {
                self.addressInfoClouse(name: "ddddd",address:"dsdfsdfsdf")
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
        viewModel.requestAddress(tableView)
    }
    
    func pushEditAddressViewController(model:AddressModel) {
        let editAddressView = AddAddressViewController()
        editAddressView.models = model
        editAddressView.reloadAddressViewClouse = { _ in
            self.reloadData()
        }
        editAddressView.type = .EditType
        editAddressView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(editAddressView, animated: true)
    }
    
    func reloadData(){
        viewModel.requestAddress(tableView)
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

extension AddressViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelectIndexPath(tableView, indexPath: indexPath, controller: self)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(tableView,indexPath:indexPath)
    }
}

extension AddressViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberRowInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AddressTableViewCell", forIndexPath: indexPath) as! AddressTableViewCell
        viewModel.configCell(cell, indexPath: indexPath)
        cell.selectionStyle = .None
        return cell
    }
    
}



