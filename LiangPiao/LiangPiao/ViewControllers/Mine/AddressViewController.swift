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

typealias AddressInfoClouse = (_ model:AddressModel) -> Void
typealias ReloadConfigTableView = () ->Void

class AddressViewController: UIViewController {

    var tableView:UITableView!
    var addAddressView:AddAddressView!
    var viewModel = AddressViewModel.shareInstance
    var addressType:AddressType!
    
    var addressInfoClouse:AddressInfoClouse!
    var reloadConfigTableView:ReloadConfigTableView!
    
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
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: "AddressTableViewCell")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-49)
        }
        
        addAddressView = AddAddressView()
        addAddressView.addButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            let editAddress = AddAddressViewController()
            editAddress.reloadAddressViewClouse = { _ in
                self.reloadData()
            }
            NavigationPushView(self, toConroller: editAddress)
        }
        self.view.addSubview(addAddressView)
        
        addAddressView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.height.equalTo(49)
        }
        
        self.bindViewModle()
    }
    
    override func backBtnPress(_ sender: UIButton) {
        if reloadConfigTableView != nil {
            reloadConfigTableView()
        }
        self.navigationController?.popViewController(animated: true)
    }

    func bindViewModle(){
//        viewModel.reactive.trigger(for: (#selector(AddressViewModel.tableViewDidSelectIndexPath(_:indexPath:controller:))).observe { (action) in
//        }
        
        viewModel.addressTableViewSelect = { indexPath in
            if self.addressInfoClouse != nil {
                self.addressInfoClouse(AddressModel.init(fromDictionary: self.viewModel.addressModels[indexPath.row] as! NSDictionary))
            }
            self.navigationController?.popViewController(animated: true)
        }
        viewModel.requestAddress(tableView)
        
        viewModel.reloadConfimAddress = { model in
            if self.addressInfoClouse != nil {
                self.addressInfoClouse(model)
            }
        }
    }
    
    func pushEditAddressViewController(_ model:AddressModel) {
        let editAddressView = AddAddressViewController()
        editAddressView.models = model
        editAddressView.reloadAddressViewClouse = { _ in
            self.reloadData()
        }
        editAddressView.type = .editType
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectIndexPath(tableView, indexPath: indexPath, controller: self)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRow(tableView,indexPath:indexPath)
    }
}

extension AddressViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
        viewModel.configCell(cell, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
}



