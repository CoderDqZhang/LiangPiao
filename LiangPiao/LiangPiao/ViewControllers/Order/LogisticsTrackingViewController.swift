//
//  LogisticsTrackingViewController.swift
//  LiangPiao
//
//  Created by Zhang on 2017/3/20.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class LogisticsTrackingViewController: UIViewController {

    let viewModel = LogisticsTrackingViewModel()
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
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.register(LogisticsTableViewCell.self, forCellReuseIdentifier: "LogisticsTableViewCell")
        tableView.register(DeverliyTypeTableViewCell.self, forCellReuseIdentifier: "DeverliyTypeTableViewCell")
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
        }
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

extension LogisticsTrackingViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(tableView, indexPath:indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return viewModel.estimatedHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeiFootView(tableView, section: section)
    }
}

extension LogisticsTrackingViewController : UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogisticsTableViewCell", for: indexPath) as! LogisticsTableViewCell
            cell.selectionStyle = .none
            viewModel.tableViewCellUserAddressTableViewCell(cell, indexPath:indexPath)
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeverliyTypeTableViewCell", for: indexPath) as! DeverliyTypeTableViewCell
            viewModel.tableViewDeverliyTypeTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.layoutMargins = UIEdgeInsets.init();
            return cell
        }
    }
}

