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
        self.view.backgroundColor = UIColor.whiteColor()
        self.setNavigationItemBack()
        self.setupForDismissKeyboard()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        viewModel.controller = self
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(LogisticsTableViewCell.self, forCellReuseIdentifier: "LogisticsTableViewCell")
        tableView.registerClass(DeverliyTypeTableViewCell.self, forCellReuseIdentifier: "DeverliyTypeTableViewCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(tableView, indexPath:indexPath)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         return viewModel.estimatedHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeiFootView(tableView, section: section)
    }
}

extension LogisticsTrackingViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberRowInSection(section)
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("LogisticsTableViewCell", forIndexPath: indexPath) as! LogisticsTableViewCell
            cell.selectionStyle = .None
            viewModel.tableViewCellUserAddressTableViewCell(cell, indexPath:indexPath)
            return cell
        default :
            let cell = tableView.dequeueReusableCellWithIdentifier("DeverliyTypeTableViewCell", forIndexPath: indexPath) as! DeverliyTypeTableViewCell
            viewModel.tableViewDeverliyTypeTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .None
            cell.layoutMargins = UIEdgeInsets.init();
            return cell
        }
    }
}

