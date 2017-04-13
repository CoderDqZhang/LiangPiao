//
//  DelivererPushViewController.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class DelivererPushViewController: UIViewController {

    let viewModel = DeverliyPushViewModel()
    var deliveryView:GloableBottomButtonView!
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = viewModel.controllerTitle()
        self.view.backgroundColor = UIColor.white
        self.setNavigationItemBack()
        self.setupForDismissKeyboard()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        viewModel.controller = self
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UserAddressTableViewCell.self, forCellReuseIdentifier: "UserAddressTableViewCell")
        tableView.register(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.register(GloabTitleAndTextFieldCell.self, forCellReuseIdentifier: "GloabTitleAndTextFieldCell")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(45)
        }
        
        deliveryView = GloableBottomButtonView.init(frame: nil, title: "确认发货", tag: 1, action: { (tag) in
            self.viewModel.orderExpressRequest()
        })
        
        self.view.addSubview(deliveryView)
        self.bindViewModel()
    }

    func bindViewModel(){
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

extension DelivererPushViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectRowAtIndexPath(indexPath, controller:self)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeiFootView(tableView, section: section)
    }
}

extension DelivererPushViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserAddressTableViewCell", for: indexPath) as! UserAddressTableViewCell
            cell.selectionStyle = .none
            viewModel.tableViewCellUserAddressTableViewCell(cell, indexPath:indexPath)
            return cell
        default :
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndDetailImageCell", for: indexPath) as! GloabTitleAndDetailImageCell
                viewModel.tableViewGloabTitleAndDetailImageCell(cell, indexPath: indexPath)
                cell.selectionStyle = .none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GloabTitleAndTextFieldCell", for: indexPath) as! GloabTitleAndTextFieldCell
                cell.textField.keyboardType = .numberPad
                viewModel.tableViewCellGloabTitleAndTextFieldCell(cell, indexPath: indexPath)
                cell.selectionStyle = .none
                return cell
            }
            
        }
    }
}

