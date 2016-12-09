//
//  MySellConfimViewController.swift
//  LiangPiao
//
//  Created by Zhang on 08/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class MySellConfimViewController: UIViewController {
    
    var tableView:UITableView!
    var expressage:ZHPickView!
    var viewModel = MySellConfimViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "确认订单"
        self.setUpView()
        self.setNavigationItem()
        self.bindViewModel()
        self.talKingDataPageName = "确认订单"
        self.setupForDismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    deinit {
    }
    
    func setUpView() {
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .OnDrag
        tableView.registerClass(MySellPriceTableViewCell.self, forCellReuseIdentifier: "MySellPriceTableViewCell")
        tableView.registerClass(GloabTitleNumberCountTableViewCell.self, forCellReuseIdentifier: "GloabTitleNumberCountTableViewCell")
        tableView.registerClass(MySellIntrouductTableViewCell.self, forCellReuseIdentifier: "MySellIntrouductTableViewCell")
        tableView.registerClass(MySellRowTableViewCell.self, forCellReuseIdentifier: "MySellRowTableViewCell")
        tableView.registerClass(MySellRowTypeTableViewCell.self, forCellReuseIdentifier: "MySellRowTypeTableViewCell")
        tableView.registerClass(MySellServiceTableViewCell.self, forCellReuseIdentifier: "MySellServiceTableViewCell")
        tableView.registerClass(GloabTitleAndDetailImageCell.self, forCellReuseIdentifier: "GloabTitleAndDetailImageCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.equalTo(self.view.snp_left).offset(0)
            make.right.equalTo(self.view.snp_right).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        }
        
    }
    
    func setNavigationItem(){
        self.setNavigationItemBack()
    }
    
    
    func bindViewModel() {
        viewModel.controller = self
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

extension MySellConfimViewController : UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.tableViewHeightForFooterInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.tableViewHeightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.tableViewDidSelect(indexPath)
    }
}

extension MySellConfimViewController : UITableViewDataSource {
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewNumberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("MySellPriceTableViewCell", forIndexPath: indexPath) as! MySellPriceTableViewCell
                cell.selectionStyle = .None
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("MySellIntrouductTableViewCell", forIndexPath: indexPath) as! MySellIntrouductTableViewCell
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleNumberCountTableViewCell", forIndexPath: indexPath) as! GloabTitleNumberCountTableViewCell
                viewModel.tableViewCellGloabTitleNumberCountTableViewCell(cell, indexPath: indexPath)
                cell.selectionStyle = .None
                return cell
            }
        case 1:
            switch indexPath.row {
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("MySellRowTableViewCell", forIndexPath: indexPath) as! MySellRowTableViewCell
                cell.selectionStyle = .None
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("MySellRowTypeTableViewCell", forIndexPath: indexPath) as! MySellRowTypeTableViewCell
                cell.selectionStyle = .None
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("GloabTitleAndDetailImageCell", forIndexPath: indexPath) as! GloabTitleAndDetailImageCell
                viewModel.tableViewGloabTitleAndDetailImageCell(cell, indexPath:indexPath)
                cell.selectionStyle = .None
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("MySellServiceTableViewCell", forIndexPath: indexPath) as! MySellServiceTableViewCell
            viewModel.tableViewMySellServiceTableViewCell(cell, indexPath: indexPath)
            cell.selectionStyle = .None
            return cell
        }
    }
}
